import 'dart:developer' as dev;
import 'dart:io';
import 'dart:math';
import 'package:ElevatED/features/data/models/video/stream/stream_chunk_info.dart';
import 'package:ElevatED/features/data/models/video/stream/stream_video_metadata.dart';
import 'package:ElevatED/features/data/models/video/video.dart';
import 'package:ElevatED/features/domain/repositories/video_repository.dart';
import 'package:ElevatED/features/domain/usecases/send_activity_point_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/orderable/orderable.dart';

part '../../state/video/video_streaming_state.dart';

/// Cubit responsible for handling video streaming.
///
/// NOTE: Implementation is currently incomplete. Required methods are
/// provided as stubs and must be implemented in the upcoming iterations.
class VideoStreamingCubit extends Cubit<VideoStreamingState> {
  final VideoRepository repository;
  final SendActivityPointUseCase sendActivityPointUseCase;

  static const int bufferAheadChunks = 1; // keep 1 ahead
  static const int chunkSize = 1024 * 1024 * 1; // 1 MB per chunk

  // Internal state
  File? _videoFile;
  StreamVideoMetadata? _metadata;
  final Map<int, StreamChunkInfo> _chunkCache = {};
  Timer? _bufferTimer;
  String? _videoUrl;
  VideoPlayerController? _controller;
  List<Orderable>? _courseItems;
  int? _currentIndex;
  Video? _currentVideo;
  int _downloadedBytes = 0;
  bool isBuffering = false;
  int? totalSize;

  VideoStreamingCubit(this.repository, this.sendActivityPointUseCase)
      : super(const VideoStreamingInitial());

  // Provide controller from UI so cubit can control playback/mute
  void attachController(VideoPlayerController controller) {
    _controller = controller;
  }

  // -------------------- Navigation helpers --------------------
  bool canNavigateNext() {
    _loadCacheIfNeeded();
    if (_courseItems == null || _currentIndex == null) return false;
    return _currentIndex! < _courseItems!.length - 1;
  }

  bool canNavigatePrevious() {
    _loadCacheIfNeeded();
    if (_courseItems == null || _currentIndex == null) return false;
    return _currentIndex! > 0;
  }

  Future<void> navigateToNext() async {
    if (!canNavigateNext()) return;
    final nextIndex = _currentIndex! + 1;
    await _navigateToIndex(nextIndex);
  }

  Future<void> navigateToPrevious() async {
    if (!canNavigatePrevious()) return;
    final prevIndex = _currentIndex! - 1;
    await _navigateToIndex(prevIndex);
  }

  // ---------------------------------------------------------------------------
  // Initialization & buffering
  // ---------------------------------------------------------------------------
  Future<void> initialize({void Function(String)? loadComments}) async {
    _loadCacheIfNeeded();
    if (_courseItems == null || _currentIndex == null) {
      emit(const VideoStreamingError(message: 'No course items in cache'));
      return;
    }

    final item = _courseItems![_currentIndex!];
    if (item is Video) {
      _videoUrl = item.videoUrl;
      _currentVideo = item;
    } else {
      emit(const VideoStreamingError(message: 'Current item is not a video'));
      return;
    }

    emit(const VideoStreamingLoading(progress: 0.0, status: 'Initializing'));

    if (loadComments != null) {
      loadComments(_videoUrl!);
    }

    try {
      // Clean resources if any
      await _cleanup();

      // Create temp file
      _videoFile = await repository.createTempVideoFile(_videoUrl!);

      // Download first two chunks (0 & 1)
      await _downloadChunk(0);

      // Ready!
      if (_videoFile != null && _metadata != null) {
        emit(VideoStreamingReady(
          videoFile: _videoFile!,
          metadata: _metadata!,
          currentVideo: _currentVideo ??
              const Video(id: 0, index: 0, title: 'Video', videoUrl: ''),
        ));

        // Start periodic buffering
        _bufferTimer = Timer.periodic(const Duration(seconds: 2), (_) async {
          await _ensureBufferedAhead();
        });
      }
    } catch (e) {
      emit(VideoStreamingError(message: e.toString()));
    }
  }

  Future<void> getVideoChunkAndMetadata({
    required String videoUrl,
    required int start,
    required int end,
  }) async {
    try {
      final response = await repository.streamVideoChunk(videoUrl, start, end);
      // Store metadata if not present
      _metadata ??= response.metadata;
      totalSize ??= _metadata!.totalSize;
      // Write chunk to file
      if (_videoFile != null) {
        await repository.writeChunkToFile(_videoFile!, response.data, start);
      }
      // Cache info
      final index = start ~/ chunkSize;
      _chunkCache[index] = StreamChunkInfo(
        start: start,
        end: end,
        size: response.data.length,
        data: response.data,
        downloadedAt: DateTime.now(),
      );

      _downloadedBytes += response.data.length;
    } catch (e) {
      emit(VideoStreamingError(message: e.toString()));
    }
  }

  // Toggle play / pause on attached controller
  void togglePlayPause() {
    if (_controller == null) return;
    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
  }

  // Toggle mute / unmute
  void toggleMute() {
    if (_controller == null) return;
    final vol = _controller!.value.volume;
    _controller!.setVolume(vol == 0 ? 1.0 : 0.0);
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------
  Future<void> _ensureBufferedAhead() async {
    // We need controller, total size **and** duration to map time → bytes.
    if (_controller == null || _metadata == null) return;

    // Total video duration reported by video_player (milliseconds)
    final int durationMs = _controller!.value.duration.inMilliseconds;
    if (durationMs <= 0) return;

    // Current play-head position (milliseconds)
    final int positionMs = _controller!.value.position.inMilliseconds;

    // Translate play-head time → byte offset using the file size in metadata.
    final int totalBytes = _metadata!.totalSize;
    if (totalBytes <= 0) return;

    final int currentByte = ((positionMs / durationMs) * totalBytes).floor();
    final int currentChunk = currentByte ~/ chunkSize;

    // Make sure we always have at least `bufferAheadChunks` chunks prefetched.
    final int targetChunk = currentChunk + bufferAheadChunks;
    final int lastCached = _getLastCachedChunk();
    final int totalChunks = _getTotalChunks();

    if (lastCached >= targetChunk) return;

    // Ensure two chunks ahead
    if (lastCached + 1 < totalChunks && !isBuffering) {
      await _downloadChunk(lastCached + 1);
    }
  }

  // ---------------------------------------------------------------------------
// Internal helpers
// ---------------------------------------------------------------------------

  Future<void> _cleanup() async {
    _bufferTimer?.cancel();
    _chunkCache.clear();
    if (_videoFile != null && await _videoFile!.exists()) {
      await _videoFile!.delete();
    }
    _videoFile = null;
    _metadata = null;
    _currentVideo = null;
    _downloadedBytes = 0;
  }

  void _loadCacheIfNeeded() {
    _courseItems ??= MemoryCache.getCurrentCourseItems();
    _currentIndex ??= MemoryCache.getCurrentCourseItemIndex();
  }

  Future<void> _navigateToIndex(int index) async {
    _loadCacheIfNeeded();
    if (_courseItems == null || index < 0 || index >= _courseItems!.length) {
      return;
    }

    final nextItem = _courseItems![index];
    MemoryCache.pushCurrentCourseItemIndex(index);

    if (nextItem is Video) {
      await _cleanup();
      _currentIndex = index;
      _currentVideo = nextItem;
      await initialize();
    } else if (nextItem is Assignment) {
      emit(const VideoStreamingError(
          message: 'Assignment screen not implemented'));
    }
  }

  int _getTotalChunks() {
    if (_metadata == null) return 0;
    return (_metadata!.totalSize / chunkSize).ceil();
  }

  int _getLastCachedChunk() {
    if (_chunkCache.isEmpty) return -1;
    int lastChunk = _chunkCache.keys.reduce((a, b) => a > b ? a : b);

    dev.log('lastChunk: $lastChunk ::: totalChunks: ${_getTotalChunks()}');

    return lastChunk;
  }

  Future<void> _downloadChunk(int index) async {
    if (_videoUrl == null || _chunkCache.containsKey(index)) return;

    isBuffering = true;

    final start = index * chunkSize;
    final calculatedEnd = ((index + 1) * chunkSize) - 1;

    final end = min(calculatedEnd, totalSize ?? chunkSize + 1);

    final response = await repository.streamVideoChunk(_videoUrl!, start, end);

    _metadata ??= response.metadata;
    if (_videoFile != null) {
      await repository.writeChunkToFile(_videoFile!, response.data, start);
    }

    _chunkCache[index] = StreamChunkInfo(
      start: start,
      end: end,
      size: response.data.length,
      data: response.data,
      downloadedAt: DateTime.now(),
    );

    _downloadedBytes += response.data.length;
    isBuffering = false;
  }

  String get currentVideoUrl => _videoUrl ?? "url not found";

  @override
  Future<void> close() async {
    await _cleanup();
    return super.close();
  }

  Future<void> sendActivityPoint(int secondsSpent) async {
    try {
      final userId = MemoryCache.getUserData()?.id;
      if (userId == null && secondsSpent <= 10) return;

      final hours = secondsSpent / 3600.0;
      await sendActivityPointUseCase(
        userId: userId!,
        hours: hours,
      );
    } catch (e) {
      // Optionally log or handle error
    }
  }
}

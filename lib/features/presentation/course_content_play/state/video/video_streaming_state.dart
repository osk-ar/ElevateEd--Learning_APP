part of '../../cubit/video/video_streaming_cubit.dart';

// new states
abstract class VideoStreamingState extends Equatable {
  final Video? currentVideo;

  const VideoStreamingState({this.currentVideo});

  @override
  List<Object?> get props => [currentVideo];
}

class VideoStreamingInitial extends VideoStreamingState {
  const VideoStreamingInitial() : super();
}

class VideoStreamingLoading extends VideoStreamingState {
  final double progress;
  final String status;

  const VideoStreamingLoading({
    required this.progress,
    required this.status,
    super.currentVideo,
  });

  @override
  List<Object?> get props => [progress, status, currentVideo];
}

class VideoStreamingReady extends VideoStreamingState {
  final File videoFile;
  final StreamVideoMetadata metadata;

  const VideoStreamingReady({
    required this.videoFile,
    required this.metadata,
    required Video currentVideo,
  }) : super(currentVideo: currentVideo);

  @override
  List<Object?> get props => [videoFile, metadata, currentVideo];
}

class VideoStreamingError extends VideoStreamingState {
  final String message;
  final Exception? exception;

  const VideoStreamingError({
    required this.message,
    this.exception,
    super.currentVideo,
  });

  @override
  List<Object?> get props => [message, exception, currentVideo];
}

class VideoStreamingBuffering extends VideoStreamingState {
  final File videoFile;
  final double bufferProgress;
  final int currentPosition;

  const VideoStreamingBuffering({
    required this.videoFile,
    required this.bufferProgress,
    required this.currentPosition,
    required Video currentVideo,
  }) : super(currentVideo: currentVideo);

  @override
  List<Object?> get props =>
      [videoFile, bufferProgress, currentPosition, currentVideo];
}

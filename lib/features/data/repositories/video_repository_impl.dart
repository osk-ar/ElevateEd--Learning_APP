import 'dart:io';

import 'dart:typed_data';
import 'package:ElevatED/features/data/data%20sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data/models/video/stream/stream_response.dart';
import 'package:ElevatED/features/domain/repositories/video_repository.dart';
import 'package:path_provider/path_provider.dart';

class VideoRepositoryImpl implements VideoRepository {
  final RemoteDataSource _remoteDataSource;

  VideoRepositoryImpl(this._remoteDataSource);

  @override
  Future<File> createTempVideoFile(String videoUrl) async {
    final tempDir = await getTemporaryDirectory();
    final fileName =
        'streaming_${videoUrl.hashCode}_${DateTime.now().millisecondsSinceEpoch}.mp4';
    return File('${tempDir.path}/$fileName');
  }

  @override
  Future<void> writeChunkToFile(File file, Uint8List data, int position) async {
    final fileHandle = await file.open(mode: FileMode.writeOnlyAppend);
    try {
      await fileHandle.setPosition(position);
      await fileHandle.writeFrom(data);
      await fileHandle.flush();
    } finally {
      await fileHandle.close();
    }
  }

  @override
  Future<void> cleanupTempFiles() async {
    try {
      final tempDir = await getTemporaryDirectory();
      final files = tempDir.listSync();

      for (final file in files) {
        if (file.path.contains('streaming_') && file.path.endsWith('.mp4')) {
          await file.delete();
        }
      }
    } catch (e) {
      // Log cleanup error but don't throw
      print('Error cleaning up temp files: $e');
    }
  }

  @override
  Future<StreamResponse> streamVideoChunk(String videoUrl, int start, int end) {
    return _remoteDataSource.streamVideoChunk(videoUrl, start, end);
  }
}

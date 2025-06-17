import 'dart:io';
import 'dart:typed_data';
import 'package:ElevatED/features/data/models/video/stream/stream_response.dart';

abstract class VideoRepository {
  Future<StreamResponse> streamVideoChunk(String videoUrl, int start, int end);
  Future<File> createTempVideoFile(String videoUrl);
  Future<void> writeChunkToFile(File file, Uint8List data, int position);
  Future<void> cleanupTempFiles();
}

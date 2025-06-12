import 'dart:io';

class VideoChunkModel {
  String uploadID;
  File file;
  int chunkIndex;
  VideoChunkModel({
    required this.uploadID,
    required this.file,
    required this.chunkIndex,
  });
}

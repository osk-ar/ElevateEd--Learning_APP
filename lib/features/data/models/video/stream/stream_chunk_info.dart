import 'dart:typed_data';

class StreamChunkInfo {
  final int start;
  final int end;
  final int size;
  final Uint8List data;
  final DateTime downloadedAt;

  StreamChunkInfo({
    required this.start,
    required this.end,
    required this.size,
    required this.data,
    required this.downloadedAt,
  });
}

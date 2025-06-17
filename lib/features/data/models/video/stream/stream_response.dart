import 'dart:typed_data';

import 'package:ElevatED/features/data/models/video/stream/stream_video_metadata.dart';

class StreamResponse {
  final Uint8List data;
  final StreamVideoMetadata? metadata;
  final int start;
  final int end;

  StreamResponse({
    required this.data,
    this.metadata,
    required this.start,
    required this.end,
  });
}

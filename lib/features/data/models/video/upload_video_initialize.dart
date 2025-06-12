class UploadVideoInitializeModel {
  final String videoName;
  final int videoSize;
  final int chunksCount;
  UploadVideoInitializeModel(this.videoName, this.videoSize, this.chunksCount);

  Map<String, dynamic> toJson() {
    return {
      'fileName': videoName,
      'fileSize': videoSize,
      'totalChunks': chunksCount,
    };
  }
}

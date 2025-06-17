class UploadVideoInitializeModel {
  final String videoName;
  final int videoSize;
  final int chunksCount;
  final int courseId;
  UploadVideoInitializeModel(
      this.videoName, this.videoSize, this.chunksCount, this.courseId);

  Map<String, dynamic> toJson() {
    return {
      'title': videoName,
      'fileSize': videoSize,
      'totalChunks': chunksCount,
      'courseId': courseId,
    };
  }
}

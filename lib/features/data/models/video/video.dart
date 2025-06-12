import 'package:ElevatED/features/data/models/video/comment.dart';

class Video {
  int index;
  String title;
  String description;
  String videoUrl;
  List<Comment> comments;

  // Normal constructor
  Video({
    required this.index,
    required this.title,
    required this.description,
    required this.videoUrl,
    this.comments = const [],
  });

  // fromJson constructor
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      index: json['id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['videoUrl'],
      comments: json['comments'] ??
          const []
              .map<Comment>((comment) => Comment.fromJson(comment))
              .toList(),
    );
  }
}

import 'package:ElevatED/features/data/models/orderable/orderable.dart';
import 'package:ElevatED/features/data/models/video/comment.dart';

class Video extends Orderable {
  final String videoUrl;
  final List<Comment> comments;

  // Normal constructor
  const Video({
    required super.id,
    required super.index,
    required super.title,
    required this.videoUrl,
    this.comments = const [],
  });

  // fromJson constructor
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      index: json['index'],
      title: json['title'],
      videoUrl: json['videoUrl'],
      comments: json['comments'] ??
          const []
              .map<Comment>((comment) => Comment.fromJson(comment))
              .toList(),
    );
  }

  @override
  List<Object> get props => [...super.props, videoUrl, comments];
}

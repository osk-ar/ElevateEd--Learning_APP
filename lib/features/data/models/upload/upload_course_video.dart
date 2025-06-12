import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';

class UploadCourseVideo extends NormalizedCourseContent {
  final String path;
  final String extension;

  UploadCourseVideo({
    required super.index,
    required super.title,
    required this.path,
    required this.extension,
  });
}

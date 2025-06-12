// ignore_for_file: must_be_immutable

import 'package:ElevatED/features/data/models/assignment/question.dart';

abstract class NormalizedCourseContent {
  int index;
  String title;
  NormalizedCourseContent({
    required this.index,
    required this.title,
  });
}

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

class NormalizedCourseAssignment extends NormalizedCourseContent {
  final List<Question> questions;

  NormalizedCourseAssignment(
      {required super.index, required super.title, required this.questions});
}

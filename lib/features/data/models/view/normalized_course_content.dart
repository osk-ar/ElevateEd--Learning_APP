// ignore_for_file: must_be_immutable

import 'package:ElevatED/features/data/models/assignment/question.dart';

abstract class NormalizedCourseContent {
  int index;
  String title;
  NormalizedCourseContent({
    required this.index,
    required this.title,
  });

  NormalizedCourseContent copyWith({
    int? index,
    String? title,
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

  @override
  UploadCourseVideo copyWith({
    int? index,
    String? title,
  }) {
    return UploadCourseVideo(
        index: index ?? this.index,
        title: title ?? this.title,
        path: path,
        extension: extension);
  }
}

class NormalizedCourseAssignment extends NormalizedCourseContent {
  final List<Question> questions;

  NormalizedCourseAssignment(
      {required super.index, required super.title, required this.questions});

  @override
  NormalizedCourseAssignment copyWith({
    int? index,
    String? title,
  }) {
    return NormalizedCourseAssignment(
        index: index ?? this.index,
        title: title ?? this.title,
        questions: questions);
  }
}

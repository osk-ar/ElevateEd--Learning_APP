import 'package:equatable/equatable.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';

abstract class ContentState extends Equatable {
  const ContentState();

  @override
  List<Object?> get props => [];
}

class ContentInitial extends ContentState {}

class ContentLoading extends ContentState {
  final List<NormalizedCourseContent> currentContent;
  const ContentLoading(this.currentContent);

  @override
  List<Object?> get props => [currentContent];
}

class ContentUpdated extends ContentState {
  final List<NormalizedCourseContent> content;
  const ContentUpdated(this.content);

  @override
  List<Object?> get props => [content];
}

class ContentError extends ContentState {
  final String message;
  final List<NormalizedCourseContent> previousContent;
  const ContentError(this.message, this.previousContent);

  @override
  List<Object?> get props => [message, previousContent];
}

class ContentItemRemoved extends ContentState {
  final List<NormalizedCourseContent> content;
  final int removedIndex;
  const ContentItemRemoved(this.content, this.removedIndex);

  @override
  List<Object?> get props => [content, removedIndex];
}

class ContentReordered extends ContentState {
  final List<NormalizedCourseContent> content;
  final int oldIndex;
  final int newIndex;
  const ContentReordered(this.content, this.oldIndex, this.newIndex);

  @override
  List<Object?> get props => [content, oldIndex, newIndex];
}

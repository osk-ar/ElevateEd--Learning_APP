import 'package:equatable/equatable.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';

abstract class GeneralState extends Equatable {
  const GeneralState();

  @override
  List<Object?> get props => [];
}

class GeneralInitial extends GeneralState {}

class GeneralNavigated extends GeneralState {
  final int index;
  const GeneralNavigated(this.index);

  @override
  List<Object?> get props => [index];
}

class GeneralCategoriesLoading extends GeneralState {}

class GeneralCategoriesLoaded extends GeneralState {
  final List<CourseCategory> categories;
  final int selectedCategoryId;
  const GeneralCategoriesLoaded(this.categories, this.selectedCategoryId);

  @override
  List<Object?> get props => [categories, selectedCategoryId];
}

class GeneralCategoriesError extends GeneralState {
  final String message;
  const GeneralCategoriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class GeneralCategoryChanged extends GeneralState {
  final int categoryId;
  const GeneralCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class GeneralThumbnailChanged extends GeneralState {
  final String? thumbnailPath;
  const GeneralThumbnailChanged(this.thumbnailPath);

  @override
  List<Object?> get props => [thumbnailPath];
}

class GeneralCourseDetailsUpdated extends GeneralState {
  final String title;
  final String description;
  final int categoryId;
  const GeneralCourseDetailsUpdated({
    required this.title,
    required this.description,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [title, description, categoryId];
}

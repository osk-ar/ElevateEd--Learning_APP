import 'package:equatable/equatable.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();
  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<NormalizedCourse> courses;
  final List<CourseCategory> categories;
  final bool hasMore;
  final int currentPage;
  final bool isPurchasedTab;

  const CoursesLoaded({
    required this.courses,
    required this.categories,
    required this.hasMore,
    required this.currentPage,
    required this.isPurchasedTab,
  });

  @override
  List<Object?> get props =>
      [courses, categories, hasMore, currentPage, isPurchasedTab];
}

class CoursesLoadingMore extends CoursesState {
  final List<NormalizedCourse> courses;
  final List<CourseCategory> categories;
  final int currentPage;
  final bool isPurchasedTab;

  const CoursesLoadingMore({
    required this.courses,
    required this.categories,
    required this.currentPage,
    required this.isPurchasedTab,
  });

  @override
  List<Object?> get props => [courses, categories, currentPage, isPurchasedTab];
}

class CoursesError extends CoursesState {
  final String message;
  const CoursesError(this.message);

  @override
  List<Object?> get props => [message];
}

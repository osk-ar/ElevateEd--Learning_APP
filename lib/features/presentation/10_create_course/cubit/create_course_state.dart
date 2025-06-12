part of 'package:ElevatED/features/presentation/10_create_course/cubit/create_course_cubit.dart';

class CreateCourseState {}

class CreateCourseInit extends CreateCourseState {}

class CreateCourseNavigated extends CreateCourseState with EquatableMixin {
  final int index;
  CreateCourseNavigated(this.index);

  @override
  List<Object?> get props => [index];
}

class CreateCourseThumbNailChanged extends CreateCourseState
    with EquatableMixin {
  final File? thumbNail;
  CreateCourseThumbNailChanged(this.thumbNail);

  @override
  List<Object?> get props => [thumbNail];
}

class CreateCourseContentUpdated extends CreateCourseState {
  final List<NormalizedCourseContent> courseContent;
  CreateCourseContentUpdated(this.courseContent);
}

class CreateCourseQuestionsUpdated extends CreateCourseState {
  final List<Question> assignmentQuestions;
  CreateCourseQuestionsUpdated(this.assignmentQuestions);
}

class CreateCourseContentLoading extends CreateCourseState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class CreateCourseCategoryChanged extends CreateCourseState {
  final int newCategory;
  CreateCourseCategoryChanged(this.newCategory);
}

class CreateCourseCategoriesLoading extends CreateCourseState {}

class CreateCourseCategoriesLoaded extends CreateCourseState {
  final List<CourseCategory> categories;
  final int selectedCategoryID;
  CreateCourseCategoriesLoaded(this.categories, this.selectedCategoryID);
}

class CreateCourseCategoriesError extends CreateCourseState {
  final String error;
  CreateCourseCategoriesError(this.error);
}

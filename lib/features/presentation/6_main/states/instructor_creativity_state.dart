import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:equatable/equatable.dart';

abstract class InstructorCreativityState extends Equatable {
  const InstructorCreativityState();

  @override
  List<Object?> get props => [];
}

class InstructorCreativityInitial extends InstructorCreativityState {}

class InstructorCreativityLoading extends InstructorCreativityState {}

class InstructorCreativityLoaded extends InstructorCreativityState {
  final List<NormalizedCourse> uploadedCourses;
  final List<NormalizedCourse> pendingCourses;

  const InstructorCreativityLoaded({
    required this.uploadedCourses,
    required this.pendingCourses,
  });

  @override
  List<Object?> get props => [uploadedCourses, pendingCourses];
}

class InstructorCreativityError extends InstructorCreativityState {
  final String message;

  const InstructorCreativityError(this.message);

  @override
  List<Object?> get props => [message];
}

class InstructorCreativityRefreshing extends InstructorCreativityLoaded {
  const InstructorCreativityRefreshing({
    required super.uploadedCourses,
    required super.pendingCourses,
  });
}

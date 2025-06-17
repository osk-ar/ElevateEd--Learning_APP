import 'package:ElevatED/features/data/models/course/course.dart';
import 'package:equatable/equatable.dart';

class CourseDetailsState extends Equatable {
  const CourseDetailsState();

  @override
  List<Object> get props => [];
}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final Course course;
  const CourseDetailsLoaded({required this.course});
  @override
  List<Object> get props => [course];
}

class CourseDetailsError extends CourseDetailsState {
  final String message;
  const CourseDetailsError(this.message);
  @override
  List<Object> get props => [message];
}

class CourseDetailsPaymentUrlReceived extends CourseDetailsState {
  final String paymentUrl;
  const CourseDetailsPaymentUrlReceived({required this.paymentUrl});
  @override
  List<Object> get props => [paymentUrl];
}

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

class CourseDetailsDescriptionSizeChanged extends CourseDetailsState {
  final int size;
  const CourseDetailsDescriptionSizeChanged({required this.size});
  @override
  List<Object> get props => [size];
}

class CourseDetailsFavouriteChanged extends CourseDetailsState {
  final bool isFavorite;
  const CourseDetailsFavouriteChanged({required this.isFavorite});
  @override
  List<Object> get props => [isFavorite];
}

class CourseDetailsPaymentUrlReceived extends CourseDetailsState {
  final String paymentUrl;
  const CourseDetailsPaymentUrlReceived({required this.paymentUrl});
  @override
  List<Object> get props => [paymentUrl];
}

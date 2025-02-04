import 'package:equatable/equatable.dart';

class CourseDetailsState extends Equatable {
  const CourseDetailsState();

  @override
  List<Object> get props => [];
}

class CourseDetailsInitial extends CourseDetailsState {}

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

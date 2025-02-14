import 'package:ElevatED/features/presentation/course_details/states/course_details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit() : super(CourseDetailsInitial());
  int descriptionMaxSize = 3;
  bool isFavorite = false;
  void changeDescriptionSize() {
    descriptionMaxSize = descriptionMaxSize == 3 ? 10 : 3;
    print(descriptionMaxSize);
    emit(CourseDetailsDescriptionSizeChanged(size: descriptionMaxSize));
  }

  void toggleFavorite() {
    isFavorite = !isFavorite;
    print(isFavorite);
    emit(CourseDetailsFavouriteChanged(isFavorite: isFavorite));
  }
}

import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../states/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit(this.appRepository) : super(CategoriesInitial());
  final AppRepository appRepository;

  Future<void> getCategories() async {
    try {
      emit(CategoriesLoading());
      final categories = await appRepository.getCategories();
      emit(CategoriesLoaded(categories));
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  void toggleCategory(CourseCategory category) {
    if (state is CategoriesLoaded) {
      final currentState = state as CategoriesLoaded;
      final List<CourseCategory> updatedSelection =
          List.from(currentState.selectedCategories);

      if (updatedSelection.contains(category)) {
        updatedSelection.remove(category);
      } else {
        updatedSelection.add(category);
      }

      emit(CategoriesLoaded(currentState.categories,
          selectedCategories: updatedSelection));
    }
  }

  List<CourseCategory> get selectedCategories {
    if (state is CategoriesLoaded) {
      return (state as CategoriesLoaded).selectedCategories;
    }
    return [];
  }
}

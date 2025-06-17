import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';
import 'package:ElevatED/features/presentation/10_create_course/states/general_states.dart';

class GeneralCubit extends Cubit<GeneralState> {
  final AppRepository _appRepository;

  int _currentIndex = 0;
  int _selectedCategoryId = 0;
  String _title = '';
  String _description = '';
  List<CourseCategory> _categories = [];

  GeneralCubit(this._appRepository) : super(GeneralInitial()) {
    fetchCategories();
  }

  // Getters
  int get currentIndex => _currentIndex;
  int get selectedCategoryId => _selectedCategoryId;
  String get title => _title;
  String get description => _description;
  List<CourseCategory> get categories => List.unmodifiable(_categories);

  Future<void> fetchCategories() async {
    emit(GeneralCategoriesLoading());
    try {
      _categories = await _appRepository.getCategories();
      emit(GeneralCategoriesLoaded(_categories, _selectedCategoryId));
    } catch (e) {
      emit(GeneralCategoriesError(e.toString()));
    }
  }

  void navigateTo(int index) {
    _currentIndex = index.clamp(0, 2);
    emit(GeneralNavigated(_currentIndex));
  }

  void nextStep() {
    _currentIndex = (_currentIndex + 1).clamp(0, 2);
    emit(GeneralNavigated(_currentIndex));
  }

  void previousStep() {
    _currentIndex = (_currentIndex - 1).clamp(0, 2);
    emit(GeneralNavigated(_currentIndex));
  }

  void updateCategory(int categoryId) {
    _selectedCategoryId = categoryId;
    emit(GeneralCategoryChanged(categoryId));
  }

  void updateCourseDetails({
    required String title,
    required String description,
  }) {
    _title = title;
    _description = description;
    emit(GeneralCourseDetailsUpdated(
      title: title,
      description: description,
      categoryId: _selectedCategoryId,
    ));
  }

  void reset() {
    _currentIndex = 0;
    _selectedCategoryId = 0;
    _title = '';
    _description = '';
    emit(GeneralInitial());
  }
}

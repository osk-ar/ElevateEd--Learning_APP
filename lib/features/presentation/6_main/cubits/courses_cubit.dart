import 'package:flutter_bloc/flutter_bloc.dart';
import '../states/courses_state.dart';
import 'package:ElevatED/features/domain/usecases/get_courses_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_categories_usecase.dart';
import 'package:ElevatED/features/domain/usecases/get_purchased_courses_usecase.dart';
import 'package:ElevatED/features/data/models/view/normalized_course.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final GetCoursesUseCase getCoursesUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetPurchasedCoursesUseCase getPurchasedCoursesUseCase;
  static const int _pageSize = 20;

  List<NormalizedCourse> _allCourses = [];
  List<NormalizedCourse> _purchasedCourses = [];
  List<CourseCategory> _categories = [];
  int _currentPage = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;
  bool _isPurchasedTab = false;

  CoursesCubit(
    this.getCoursesUseCase,
    this.getCategoriesUseCase,
    this.getPurchasedCoursesUseCase,
  ) : super(CoursesInitial());

  Future<void> loadCategories() async {
    try {
      _categories = await getCategoriesUseCase();
      emit(CoursesLoaded(
        courses: _isPurchasedTab ? _purchasedCourses : _allCourses,
        categories: _categories,
        hasMore: _hasMore,
        currentPage: _currentPage,
        isPurchasedTab: _isPurchasedTab,
      ));
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }

  void switchTab(bool isPurchasedTab) {
    _isPurchasedTab = isPurchasedTab;
    loadCourses();
  }

  void loadCourses() async {
    emit(CoursesLoading());
    _currentPage = 1;
    _hasMore = true;

    if (_isPurchasedTab) {
      _purchasedCourses = [];
    } else {
      _allCourses = [];
    }

    try {
      final courses = _isPurchasedTab
          ? await getPurchasedCoursesUseCase()
          : await getCoursesUseCase(
              page: _currentPage,
              pageSize: _pageSize,
            );

      if (_isPurchasedTab) {
        _purchasedCourses = courses;
        _hasMore = false;
      } else {
        _allCourses = courses;
        _hasMore = courses.length == _pageSize;
      }

      if (_categories.isEmpty) {
        await loadCategories();
      } else {
        emit(CoursesLoaded(
          courses: _isPurchasedTab ? _purchasedCourses : _allCourses,
          categories: _categories,
          hasMore: _hasMore,
          currentPage: _currentPage,
          isPurchasedTab: _isPurchasedTab,
        ));
      }
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }

  void loadMoreCourses() async {
    if (!_hasMore ||
        _isLoadingMore ||
        state is CoursesLoading ||
        _isPurchasedTab) return;

    _isLoadingMore = true;
    emit(CoursesLoadingMore(
      courses: _allCourses,
      categories: _categories,
      currentPage: _currentPage,
      isPurchasedTab: _isPurchasedTab,
    ));
    try {
      final nextPage = _currentPage + 1;
      final moreCourses = await getCoursesUseCase(
        page: nextPage,
        pageSize: _pageSize,
      );

      _allCourses.addAll(moreCourses);
      _hasMore = moreCourses.length == _pageSize;
      _currentPage = nextPage;

      emit(CoursesLoaded(
        courses: _allCourses,
        categories: _categories,
        hasMore: _hasMore,
        currentPage: _currentPage,
        isPurchasedTab: _isPurchasedTab,
      ));
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
    _isLoadingMore = false;
  }
}

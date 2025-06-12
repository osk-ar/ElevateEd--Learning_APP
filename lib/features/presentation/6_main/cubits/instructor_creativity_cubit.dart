import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/usecases/get_user_profile_usecase.dart';
import 'package:ElevatED/features/presentation/6_main/states/instructor_creativity_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorCreativityCubit extends Cubit<InstructorCreativityState> {
  final GetUserProfileUseCase _getUserProfileUseCase;

  InstructorCreativityCubit(this._getUserProfileUseCase)
      : super(InstructorCreativityInitial());

  Future<void> loadCourses() async {
    try {
      emit(InstructorCreativityLoading());
      final userData = MemoryCache.getUserData() as InstructorUserData;
      await _getUserProfileUseCase(userData.id);

      final courses = userData.createdCourses;
      final uploadedCourses = courses
          .where((course) => course.status == CourseStatusEnum.uploaded)
          .toList();
      final pendingCourses = courses
          .where((course) => course.status == CourseStatusEnum.pending)
          .toList();

      emit(InstructorCreativityLoaded(
        uploadedCourses: uploadedCourses,
        pendingCourses: pendingCourses,
      ));
    } catch (e) {
      emit(InstructorCreativityError(e.toString()));
    }
  }

  Future<void> refreshCourses() async {
    if (state is InstructorCreativityLoaded) {
      final currentState = state as InstructorCreativityLoaded;
      emit(InstructorCreativityRefreshing(
        uploadedCourses: currentState.uploadedCourses,
        pendingCourses: currentState.pendingCourses,
      ));

      try {
        final userData = MemoryCache.getUserData() as InstructorUserData;
        await _getUserProfileUseCase(userData.id);

        final courses = userData.createdCourses;
        final uploadedCourses = courses
            .where((course) => course.status == CourseStatusEnum.uploaded)
            .toList();
        final pendingCourses = courses
            .where((course) => course.status == CourseStatusEnum.pending)
            .toList();

        emit(InstructorCreativityLoaded(
          uploadedCourses: uploadedCourses,
          pendingCourses: pendingCourses,
        ));
      } catch (e) {
        emit(InstructorCreativityError(e.toString()));
      }
    }
  }
}

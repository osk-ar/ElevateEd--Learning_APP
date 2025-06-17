import 'dart:io';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

part '../states/save_profile_state.dart';

class SaveProfileCubit extends Cubit<SaveProfileState> {
  SaveProfileCubit(this.appRepository) : super(SaveProfileInitial());
  final AppRepository appRepository;

  Future<void> saveProfile({
    required File profileImage,
    required List<CourseCategory> selectedCategories,
    required String title,
    required String email,
    required String phone,
    required String description,
  }) async {
    try {
      if (!profileImage.existsSync()) {
        emit(SaveProfileError('profile_image_is_required'.tr()));
        return;
      }

      emit(SaveProfileSaving());
      // TODO: call repository to save profile with all the data
      await Future.delayed(const Duration(seconds: 1));
      emit(SaveProfileSaved());
    } catch (e) {
      emit(SaveProfileError(e.toString()));
    }
  }
}

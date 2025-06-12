import 'dart:developer';
import 'dart:io';
import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/core/services/image%20services/image_services.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/usecases/register_usecase.dart';
import 'package:ElevatED/features/presentation/3_register/states/student_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class StudentRegisterCubit extends Cubit<StudentRegisterState> {
  final RegisterUseCase registerUserUseCase;
  final SharedPreferencesService appSharedPrefs;
  final ImageServices imageServices;
  final AppRepository appRepository;
  StudentRegisterCubit(this.registerUserUseCase, this.appSharedPrefs,
      this.imageServices, this.appRepository)
      : super(StudentRegisterInitial()) {
    fetchCategories();
  }
  File? profileImage;
  List<CourseCategory> interests = [];
  List<CourseCategory> categories = [];
  bool isCategoriesLoading = false;
  String? categoriesError;

  Future<void> fetchCategories() async {
    isCategoriesLoading = true;
    categoriesError = null;
    emit(StudentRegisterLoading());
    try {
      categories = await appRepository.getCategories();
      isCategoriesLoading = false;
      emit(StudentRegisterInitial());
    } catch (e) {
      isCategoriesLoading = false;
      categoriesError = e.toString();
      emit(StudentRegisterFailure(categoriesError!));
    }
  }

  Future<void> selectImage(BuildContext context) async {
    XFile? selectedImage = await imageServices.pickImage();

    if (selectedImage == null ||
        selectedImage.path.isEmpty ||
        !context.mounted) {
      return;
    }

    profileImage = await imageServices.cropImage(context, selectedImage.path);

    if (profileImage == null) {
      log("Image is null after cropping");
      return;
    }

    emit(StudentRegisterPickedImage(imageFile: profileImage!));
  }

  void clearImage() {
    profileImage = null;
    emit(StudentRegisterImageCleared());
  }

  void editSuggestions(CourseCategory item) {
    if (interests.any((element) => element.id == item.id)) {
      interests.removeWhere((element) => element.id == item.id);
      return;
    }
    interests.add(item);
    print(interests);
  }

  bool suggestionSelected(CourseCategory item) {
    return interests.any((element) => element.id == item.id);
  }

  Future<void> register({required final String bio}) async {
    emit(StudentRegisterLoading());
    try {
      final user = User(
        userRole: MemoryCache.getUserRole(),
        fullName: MemoryCache.getFullName(),
        phoneNumber: MemoryCache.getPhone(),
        birthDate: DateTime.parse(MemoryCache.getBirthDate()!),
        email: MemoryCache.getEmail(),
        password: MemoryCache.getPassword(),
        profileImageFile: profileImage,
        description: bio,
        interests: interests,
      );

      print(user);

      UserData userData = await registerUserUseCase.call(user);

      updatesharedPrefs();

      emit(StudentRegisterSuccess(responseModel: userData));
    } catch (error) {
      print(error.toString());
      emit(StudentRegisterFailure(error.toString()));
    }
  }

  void updatesharedPrefs() {
    appSharedPrefs.setBool(AppKeys.shouldSaveAuthKey, true);
    appSharedPrefs.setString(AppKeys.emailKey, MemoryCache.getEmail()!);
    appSharedPrefs.setString(AppKeys.passwordKey, MemoryCache.getPassword()!);
  }
}

import 'dart:io';

import 'package:ElevatED/core/constants/app_keys.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/core/services/image%20services/image_services.dart';
import 'package:ElevatED/core/services/Shared%20Preferences%20Service/shared_preferences_service.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/usecases/register_usecase.dart';
import 'package:ElevatED/features/presentation/3_register/states/instructor_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/domain/repositories/app_repository.dart';

class InstructorRegisterCubit extends Cubit<InstructorRegisterState> {
  final RegisterUseCase registerUserUseCase;
  final ImageServices imageServices;
  final SharedPreferencesService appSharedPrefs;
  final AppRepository appRepository;
  InstructorRegisterCubit(this.registerUserUseCase, this.appSharedPrefs,
      this.imageServices, this.appRepository)
      : super(InstructorRegisterInitial()) {
    fetchCategories();
  }

  File? profileImage;
  List<CourseCategory> expertiseFields = [];
  List<CourseCategory> categories = [];
  bool isCategoriesLoading = false;
  String? categoriesError;

  List<String> personalLinks = [];

  Future<void> fetchCategories() async {
    isCategoriesLoading = true;
    categoriesError = null;
    emit(InstructorRegisterLoading());
    try {
      categories = await appRepository.getCategories();
      isCategoriesLoading = false;
      emit(InstructorRegisterInitial());
    } catch (e) {
      isCategoriesLoading = false;
      categoriesError = e.toString();
      emit(InstructorRegisterFailure(categoriesError!));
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
      return;
    }

    emit(InstructorRegisterPickedImage(imageFile: profileImage!));
  }

  void clearImage() {
    profileImage = null;
    emit(InstructorRegisterImageCleared());
  }

  void editExpertise(CourseCategory item) {
    if (expertiseFields.any((element) => element.id == item.id)) {
      expertiseFields.removeWhere((element) => element.id == item.id);
      return;
    }
    expertiseFields.add(item);
    print(expertiseFields);
  }

  bool suggestionSelected(CourseCategory item) {
    return expertiseFields.any((element) => element.id == item.id);
  }

  void addLinksToPersonalList(
    String facebook,
    String github,
    String linkedin,
    String portfolio,
  ) {
    if (facebook.isNotEmpty) {
      personalLinks.add(facebook);
    }
    if (github.isNotEmpty) {
      personalLinks.add(github);
    }
    if (linkedin.isNotEmpty) {
      personalLinks.add(linkedin);
    }
    if (portfolio.isNotEmpty) {
      personalLinks.add(portfolio);
    }
  }

  void updatesharedPrefs() {
    appSharedPrefs.setBool(AppKeys.shouldSaveAuthKey, true);
    appSharedPrefs.setString(AppKeys.emailKey, MemoryCache.getEmail()!);
    appSharedPrefs.setString(AppKeys.passwordKey, MemoryCache.getPassword()!);
  }

  // get dataIntent
  Future<void> register(String title, String description) async {
    emit(InstructorRegisterLoading());
    try {
      final user = User(
        userRole: MemoryCache.getUserRole(),
        fullName: MemoryCache.getFullName(),
        phoneNumber: MemoryCache.getPhone(),
        birthDate: DateTime.parse(MemoryCache.getBirthDate()!),
        email: MemoryCache.getEmail(),
        password: MemoryCache.getPassword(),
        description: description,
        professionalTitle: title,
        interests: expertiseFields,
        personalLinks: personalLinks,
        profileImageFile: profileImage,
      );

      UserData userData = await registerUserUseCase.call(user);
      updatesharedPrefs();
      emit(InstructorRegisterSuccess(user: userData));
    } catch (error) {
      print(error.toString());
      emit(InstructorRegisterFailure(error.toString()));
    }
  }

  @override
  void emit(InstructorRegisterState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}

import 'dart:io';

import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/data_intent.dart';
import 'package:ElevatED/core/helper/image_handler.dart';
import 'package:ElevatED/features/data_sources/local/app_prefs.dart';
import 'package:ElevatED/features/domain/entities/home.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/usecases/get_homeusecase.dart';
import 'package:ElevatED/features/domain/usecases/register_usecase.dart';
import 'package:ElevatED/features/presentation/register/states/instructor_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorRegisterCubit extends Cubit<InstructorRegisterState> {
  final RegisterUseCase registerUserUseCase;
  final AppPrefs appSharedPrefs;
  final GetHomeusecase getHomeusecase;
  InstructorRegisterCubit(
      this.registerUserUseCase, this.appSharedPrefs, this.getHomeusecase)
      : super(InstructorRegisterInitial());

  File? profileImage;

  List<Interests> expertiseFields = [];
  List<String> personalLinks = [];

  Future<void> selectImage(BuildContext context) async {
    profileImage = await ImageHandler.pickImage(context);
    if (profileImage == null) {
      return;
    }
    emit(InstructorRegisterPickedImage(imageFile: profileImage!));
  }

  void clearImage() {
    profileImage = null;
    emit(InstructorRegisterImageCleared());
  }

  void editSuggestions(Interests item) {
    if (expertiseFields.any((element) => element == item)) {
      expertiseFields.remove(item);
      return;
    }
    expertiseFields.add(item);
    print(expertiseFields);
  }

  bool suggestionSelected(Interests item) {
    return expertiseFields.any((element) => element == item);
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

  void updatesharedPrefs({required User authResponseData}) {
    appSharedPrefs.setBool(KeyPrefs.IS_LOGGEDIN.name, true);
    appSharedPrefs.setInt(KeyPrefs.ID.name, authResponseData.id!);
    appSharedPrefs.setString(
        KeyPrefs.ROLE.name, authResponseData.userRole!.name);
  }

  // get dataIntent
  Future<void> register(String title, String description) async {
    emit(InstructorRegisterLoading());
    try {
      final user = User(
        userRole: DataIntent.getUserRole(),
        fullName: DataIntent.getFullName(),
        phoneNumber: DataIntent.getPhone(),
        birthDate: DateTime.parse(DataIntent.getBirthDate()!),
        email: DataIntent.getEmail(),
        password: DataIntent.getPassword(),
        profileImageFile: profileImage,
        professionalTitle: title,
        description: description,
        interests: expertiseFields,
        personalLinks: personalLinks,
      );

      User userData = await registerUserUseCase.call(user);
      updatesharedPrefs(authResponseData: userData);
      Home home = await getHomeusecase.call(userData.id!);
      DataIntent.pushHomeData(home);
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

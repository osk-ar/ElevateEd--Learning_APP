import 'dart:io';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/home.dart';
import 'package:e_learning_app_gp/features/domain/usecases/get_homeusecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/register_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/student_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/image_handler.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/core/helper/theme_helper_functions.dart';

class StudentRegisterCubit extends Cubit<StudentRegisterState> {
  final RegisterUseCase registerUserUseCase;
  final GetHomeusecase getHomeusecase;
  final AppPrefs appSharedPrefs;
  StudentRegisterCubit(
      this.registerUserUseCase, this.appSharedPrefs, this.getHomeusecase)
      : super(StudentRegisterInitial());
  File? profileImage;
  List<Interests> interests = [];

  Future<void> selectImage(BuildContext context) async {
    profileImage = await ImageHandler.pickImage(context);
    if (profileImage == null) {
      return;
    }
    emit(StudentRegisterPickedImage(imageFile: profileImage!));
  }

  void clearImage() {
    profileImage = null;
    emit(StudentRegisterImageCleared());
  }

  void editSuggestions(Interests item) {
    if (interests.any((element) => element == item)) {
      interests.remove(item);
      return;
    }
    interests.add(item);
    print(interests);
  }

  bool suggestionSelected(Interests item) {
    return interests.any((element) => element == item);
  }

  Color getSelectedSuggestionTextColor(Interests item) {
    if (isLightTheme() && !suggestionSelected(item)) {
      return MyTheme.primaryColor;
    }
    return Colors.white;
  }

  Future<void> register({required final String bio}) async {
    emit(StudentRegisterLoading());
    try {
      final user = User(
        userRole: DataIntent.getUserRole(),
        fullName: DataIntent.getFullName(),
        phoneNumber: DataIntent.getPhone(),
        birthDate: DateTime.parse(DataIntent.getBirthDate()!),
        email: DataIntent.getEmail(),
        password: DataIntent.getPassword(),
        profileImageFile: profileImage,
        description: bio,
        interests: interests,
      );

      print(user);

      User userData = await registerUserUseCase.call(user);
      updatesharedPrefs(authResponseData: userData);
      Home home = await getHomeusecase.call(userData.id!);
      DataIntent.pushHomeData(home);
      emit(StudentRegisterSuccess(responseModel: userData));
    } catch (error) {
      print(error.toString());
      emit(StudentRegisterFailure(error.toString()));
    }
  }

  void updatesharedPrefs({required User authResponseData}) {
    appSharedPrefs.setBool(KeyPrefs.IS_LOGGEDIN.name, true);
    appSharedPrefs.setInt(KeyPrefs.ID.name, authResponseData.id!);
    appSharedPrefs.setString(
        KeyPrefs.ROLE.name, authResponseData.userRole!.name);
  }
}

import 'dart:io';
import 'package:ElevatED/core/helper/data_intent.dart';
import 'package:ElevatED/features/data_sources/local/app_prefs.dart';
import 'package:ElevatED/features/domain/entities/home.dart';
import 'package:ElevatED/features/domain/usecases/get_homeusecase.dart';
import 'package:ElevatED/features/domain/usecases/register_usecase.dart';
import 'package:ElevatED/features/presentation/register/states/student_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/image_handler.dart';
import 'package:ElevatED/features/domain/entities/user.dart';

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

import 'dart:io';

import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/image_handler.dart';
import 'package:e_learning_app_gp/core/helper/theme_helper_functions.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/home.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/get_homeusecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/register_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/instructor_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorRegisterCubit extends Cubit<InstructorRegisterState> {
  final RegisterUseCase registerUserUseCase;
  final AppPrefs appSharedPrefs;
  final GetHomeusecase getHomeusecase;
  InstructorRegisterCubit(
      this.registerUserUseCase, this.appSharedPrefs, this.getHomeusecase)
      : super(InstructorRegisterInitial());

  GlobalKey<FormState> instructorRegisterFormStateKey = GlobalKey<FormState>();

  FocusNode titleFocusNode = FocusNode();
  FocusNode bioFocusNode = FocusNode();
  FocusNode facebookFocusNode = FocusNode();
  FocusNode githubFocusNode = FocusNode();
  FocusNode linkedInFocusNode = FocusNode();
  FocusNode portfolioFocusNode = FocusNode();

  File? profileImage;
  TextEditingController titleController = TextEditingController();
  TextEditingController bioController = TextEditingController()
    ..text = "Hi, I'm new here! No welcome?";
  TextEditingController facebookController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController portfolioController = TextEditingController();
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

  Color getSelectedSuggestionTextColor(Interests item) {
    if (isLightTheme() && !suggestionSelected(item)) {
      return MyTheme.primaryColor;
    }
    return Colors.white;
  }

  void addLinksToPersonalList() {
    if (facebookController.text.isNotEmpty) {
      personalLinks.add(facebookController.text);
    }
    if (githubController.text.isNotEmpty) {
      personalLinks.add(githubController.text);
    }
    if (linkedInController.text.isNotEmpty) {
      personalLinks.add(linkedInController.text);
    }
    if (portfolioController.text.isNotEmpty) {
      personalLinks.add(portfolioController.text);
    }
  }

  void updatesharedPrefs({required User authResponseData}) {
    appSharedPrefs.setBool(KeyPrefs.IS_LOGGEDIN.name, true);
    appSharedPrefs.setInt(KeyPrefs.ID.name, authResponseData.id!);
    appSharedPrefs.setString(
        KeyPrefs.ROLE.name, authResponseData.userRole!.name);
  }

  // get dataIntent
  Future<void> register() async {
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
        professionalTitle: titleController.text,
        description: bioController.text,
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

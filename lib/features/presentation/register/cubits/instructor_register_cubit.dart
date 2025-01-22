import 'dart:io';

import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/image_handler.dart';
import 'package:e_learning_app_gp/core/helper/theme_helper_functions.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/register_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/instructor_register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InstructorRegisterCubit extends Cubit<InstructorRegisterState> {
  final RegisterUseCase registerUserUseCase;
  final AppPrefs appSharedPrefs;
  InstructorRegisterCubit(this.registerUserUseCase, this.appSharedPrefs)
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

  void updatesharedPrefs({String? email, String? password}) {
    if (!email.isNullOrEmpty() && !password.isNullOrEmpty()) {
      appSharedPrefs.setBool(KeyPrefs.IS_LOGGEDIN.name, true);
      appSharedPrefs.setString(KeyPrefs.EMAIL.name, email!);
      appSharedPrefs.setString(KeyPrefs.PASSWORD.name, password!);
      return;
    }

    if (appSharedPrefs.containKey(KeyPrefs.IS_LOGGEDIN.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.IS_LOGGEDIN.name);
    }
    if (appSharedPrefs.containKey(KeyPrefs.EMAIL.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.EMAIL.name);
    }
    if (appSharedPrefs.containKey(KeyPrefs.PASSWORD.name)) {
      appSharedPrefs.removeByKey(KeyPrefs.PASSWORD.name);
    }
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
      updatesharedPrefs(email: user.email, password: user.password);
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

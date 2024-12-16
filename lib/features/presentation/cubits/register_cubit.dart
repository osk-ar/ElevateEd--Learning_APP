import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/dependency_injection.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/register_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/data_intent.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUserUseCase;

  UserRole userRole = UserRole.STUDENT;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  //-
  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  //-
  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  bool isStudent = true;

  RegisterCubit(this.registerUserUseCase) : super(RegisterInitial());

  @override
  void emit(RegisterState state) {
    if (!isClosed) {
      super.emit(state);
    }
  }

  Future<void> register() async {
    emit(RegisterLoading());
    try {
      final user = User(
        userRole: userRole,
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        birthDate: DateTime.parse(birthDateController.text),
        email: emailController.text,
        password: passwordController.text,
      );

      User userData = await registerUserUseCase.call(user);
      DataIntent.pushEmail(userData.email!);
      DataIntent.pushRole(userData.userRole!);
      emit(RegisterSuccess());
    } catch (error) {
      print(error.toString());
      emit(RegisterFailure(error.toString()));
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(RegisterPasswordVisibilityChanged(isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(RegisterConfirmPasswordVisibilityChanged(isConfirmPasswordVisible));
  }

  Future<void> getDateInput(BuildContext context) async {
    DateTime? pickedTime = await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime(DateTime.now().year + 1),
      currentDate: DateTime.now(),
    );
    if (pickedTime != null) {
      String? date = pickedTime.toString().split(" ")[0];
      birthDateController.text = date;
    }
    emit(RegisterDatePicked());
  }

  void updatesharedPrefs({String? email, String? password}) {
    if (!email.isNullOrEmpty() && !password.isNullOrEmpty()) {
      sl<AppPrefs>().setBool(KeyPrefs.IS_LOGGEDIN.name, true);
      sl<AppPrefs>().setString(KeyPrefs.EMAIL.name, email!);
      sl<AppPrefs>().setString(KeyPrefs.PASSWORD.name, password!);
      return;
    }

    if (sl<AppPrefs>().containKey(KeyPrefs.IS_LOGGEDIN.name)) {
      sl<AppPrefs>().removeKey(KeyPrefs.IS_LOGGEDIN.name);
    }
    if (sl<AppPrefs>().containKey(KeyPrefs.EMAIL.name)) {
      sl<AppPrefs>().removeKey(KeyPrefs.EMAIL.name);
    }
    if (sl<AppPrefs>().containKey(KeyPrefs.PASSWORD.name)) {
      sl<AppPrefs>().removeKey(KeyPrefs.PASSWORD.name);
    }
  }

  void toggleRole(UserRole role) {
    userRole = role;
    role == UserRole.STUDENT ? isStudent = true : isStudent = false;
    emit(RegisterRoleChanged(userRole));
  }

  void pushInfoToDataIntent(BuildContext context) {
    DataIntent.pushEmail(context.read<RegisterCubit>().emailController.text);
    DataIntent.pushPassword(
        context.read<RegisterCubit>().passwordController.text);
    DataIntent.pushFullName(
        context.read<RegisterCubit>().fullNameController.text);
    DataIntent.pushPhone(
        context.read<RegisterCubit>().phoneNumberController.text);
    DataIntent.pushBirthDate(
        context.read<RegisterCubit>().birthDateController.text);
  }

  void navigateToNextScreen(BuildContext context) {
    if (userRole == UserRole.STUDENT) {
      context.pushNamed(Routes.signupAsStudentScreenRoute);
    } else {
      context.pushNamed(Routes.signupAsInstructorScreenRoute);
    }
  }
}

import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/usecases/facebook_auth_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/google_auth_usecase.dart';
import 'package:e_learning_app_gp/features/domain/usecases/register_usecase.dart';
import 'package:e_learning_app_gp/features/presentation/states/register_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/data_intent.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterUseCase registerUserUseCase;
  final GoogleAuthUseCase googleAuthUserUseCase;
  final FacebookAuthUseCase facebookAuthUserUseCase;

  late String? userRole = "Unknown";
  TextEditingController fullNameController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final FocusNode firstNameFocusNode = FocusNode();
  final FocusNode lastNameFocusNode = FocusNode();
  final FocusNode dobFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  RegisterCubit(this.registerUserUseCase, this.googleAuthUserUseCase,
      this.facebookAuthUserUseCase)
      : super(RegisterInitial());

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
      // print("${user.userRole}");
      // print("${user.firstName}");
      // print("${user.lastName}");
      // print("${user.birthDate}");
      // print("${user.phoneNumber}");
      // print("${user.email}");
      // print("${user.password}");

      User userData = await registerUserUseCase.call(user);
      DataIntent.pushUserID(userData.id!);
      DataIntent.pushToken(userData.token!);
      DataIntent.pushUserRole(userData.userRole!);
      emit(RegisterSuccess());
    } catch (error) {
      print(error.toString());
      emit(RegisterFailure(error.toString()));
    }
  }

  Future<void> registerWithGoogle() async {
    emit(RegisterLoading());
    try {
      await googleAuthUserUseCase.call();
      emit(RegisterSuccess());
    } catch (error) {
      emit(RegisterFailure(error.toString()));
    }
  }

  Future<void> registerWithFacebook() async {
    emit(RegisterLoading());
    try {
      var user = await facebookAuthUserUseCase.call();
      print("User is: $user");
      emit(RegisterSuccess());
    } catch (error) {
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
        lastDate: DateTime(DateTime.now().year),
        barrierColor: Colors.red.shade400);
    if (pickedTime != null) {
      String? date = pickedTime.toString().split(" ")[0];
      birthDateController.text = date;
    }
    emit(RegisterDatePicked());
  }
}

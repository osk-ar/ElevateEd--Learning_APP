import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterState.initial());

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void toggleRole(UserRole role) {
    emit(state.copyWith(userRole: role));
  }

  void navigateToNextScreen(BuildContext context) {
    if (!context.mounted) {
      return;
    }
    if (state.userRole == UserRole.STUDENT) {
      context.pushNamed(Routes.signupAsStudentScreenRoute);
    } else {
      context.pushNamed(Routes.signupAsInstructorScreenRoute);
    }
  }
}

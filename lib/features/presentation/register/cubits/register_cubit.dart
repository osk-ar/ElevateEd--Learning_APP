import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/features/presentation/register/states/register_state.dart';
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
    if (state.userRole == UserRole.student) {
      context.pushNamed(Routes.signupAsStudentScreenRoute);
    } else {
      context.pushNamed(Routes.signupAsInstructorScreenRoute);
    }
  }
}

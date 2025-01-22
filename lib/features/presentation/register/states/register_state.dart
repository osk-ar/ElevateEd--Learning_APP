import 'package:e_learning_app_gp/core/constants/enum.dart';

class RegisterState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final UserRole userRole;

  const RegisterState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.userRole,
  });

  // Initial state -- constructor
  factory RegisterState.initial() {
    return const RegisterState(
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
      userRole: UserRole.STUDENT,
    );
  }

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    UserRole? userRole,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      userRole: userRole ?? this.userRole,
    );
  }
}

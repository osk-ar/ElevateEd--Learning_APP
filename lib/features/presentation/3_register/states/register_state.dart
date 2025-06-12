import 'package:ElevatED/core/constants/enum.dart';

class RegisterState {
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final UserRoleEnum userRole;

  const RegisterState({
    required this.isPasswordVisible,
    required this.isConfirmPasswordVisible,
    required this.userRole,
  });

  factory RegisterState.initial() {
    return const RegisterState(
      isPasswordVisible: false,
      isConfirmPasswordVisible: false,
      userRole: UserRoleEnum.student,
    );
  }

  RegisterState copyWith({
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    UserRoleEnum? userRole,
  }) {
    return RegisterState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      userRole: userRole ?? this.userRole,
    );
  }
}

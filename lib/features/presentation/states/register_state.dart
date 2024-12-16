import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterPasswordVisibilityChanged extends RegisterState {
  final bool isPasswordVisible;

  RegisterPasswordVisibilityChanged(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}

class RegisterConfirmPasswordVisibilityChanged extends RegisterState {
  final bool isConfirmPasswordVisible;

  RegisterConfirmPasswordVisibilityChanged(this.isConfirmPasswordVisible);

  @override
  List<Object?> get props => [isConfirmPasswordVisible];
}

class RegisterRoleChanged extends RegisterState {
  final UserRole userRole;

  RegisterRoleChanged(this.userRole);

  @override
  List<Object?> get props => [userRole];
}

class RegisterDatePicked extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

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

class RegisterFailure extends RegisterState {
  final String error;

  RegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

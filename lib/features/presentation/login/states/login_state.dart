import 'package:e_learning_app_gp/features/domain/entities/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginPasswordVisibilityChanged extends LoginState {
  final bool isPasswordVisible;

  LoginPasswordVisibilityChanged(this.isPasswordVisible);
}

class LoginRememberMeChanged extends LoginState {
  final bool isRememberMeChecked;

  LoginRememberMeChanged(this.isRememberMeChecked);
}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;

  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

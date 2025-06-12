import 'package:ElevatED/features/data/models/user_data.dart';

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
  final UserData user;

  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);
}

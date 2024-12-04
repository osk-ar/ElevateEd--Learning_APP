import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginPasswordVisibilityChanged extends LoginState {
  final bool isPasswordVisible;

  LoginPasswordVisibilityChanged(this.isPasswordVisible);

  @override
  List<Object?> get props => [isPasswordVisible];
}

class LoginDataOTPProfileLoaded extends LoginState {
  final User user;

  LoginDataOTPProfileLoaded(this.user);

  @override
  List<Object?> get props => [user.fullName, user.profileImage];
}

class LoginUserNotFound extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

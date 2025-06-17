part of 'package:ElevatED/features/presentation/5_forget_password/cubit/change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangePasswordLoading extends ChangePasswordState {}

class ChangePasswordSuccess extends ChangePasswordState {}

class ChangePasswordError extends ChangePasswordState {
  final String error;

  ChangePasswordError({required this.error});
}

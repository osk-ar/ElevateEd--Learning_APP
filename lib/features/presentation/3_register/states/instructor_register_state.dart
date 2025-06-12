import 'dart:io';

import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:equatable/equatable.dart';

class InstructorRegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InstructorRegisterInitial extends InstructorRegisterState {}

class InstructorRegisterPickedImage extends InstructorRegisterState {
  final File imageFile;
  InstructorRegisterPickedImage({required this.imageFile});

  @override
  List<Object?> get props => [imageFile];
}

class InstructorRegisterImageCleared extends InstructorRegisterState {
  InstructorRegisterImageCleared();

  @override
  List<Object?> get props => [];
}

class InstructorRegisterLoading extends InstructorRegisterState {}

class InstructorRegisterSuccess extends InstructorRegisterState {
  final UserData user;

  InstructorRegisterSuccess({required this.user});
}

class InstructorRegisterFailure extends InstructorRegisterState {
  final String error;

  InstructorRegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

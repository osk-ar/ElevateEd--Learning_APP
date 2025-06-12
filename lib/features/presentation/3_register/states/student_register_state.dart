import 'dart:io';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:equatable/equatable.dart';

abstract class StudentRegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StudentRegisterInitial extends StudentRegisterState {}

class StudentRegisterPickedImage extends StudentRegisterState {
  final File imageFile;
  StudentRegisterPickedImage({required this.imageFile});

  @override
  List<Object?> get props => [imageFile];
}

class StudentRegisterImageCleared extends StudentRegisterState {
  StudentRegisterImageCleared();

  @override
  List<Object?> get props => [];
}

class StudentRegisterLoading extends StudentRegisterState {}

class StudentRegisterSuccess extends StudentRegisterState {
  final UserData responseModel;

  StudentRegisterSuccess({required this.responseModel});
}

class StudentRegisterFailure extends StudentRegisterState {
  final String error;

  StudentRegisterFailure(this.error);

  @override
  List<Object?> get props => [error];
}

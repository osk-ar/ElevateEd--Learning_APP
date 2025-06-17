part of '../cubits/save_profile_cubit.dart';

abstract class SaveProfileState extends Equatable {
  const SaveProfileState();

  @override
  List<Object?> get props => [];
}

class SaveProfileInitial extends SaveProfileState {}

class SaveProfileSaving extends SaveProfileState {}

class SaveProfileSaved extends SaveProfileState {}

class SaveProfileError extends SaveProfileState {
  final String message;
  const SaveProfileError(this.message);
  @override
  List<Object?> get props => [message];
}

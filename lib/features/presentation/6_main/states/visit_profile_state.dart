part of '../cubits/visit_profile_cubit.dart';

abstract class VisitProfileState extends Equatable {
  const VisitProfileState();

  @override
  List<Object?> get props => [];
}

class VisitProfileInitial extends VisitProfileState {}

class VisitProfileLoading extends VisitProfileState {}

class VisitProfileLoaded extends VisitProfileState {
  final UserData profile;
  const VisitProfileLoaded(this.profile);
  @override
  List<Object?> get props => [profile];
}

class VisitProfileError extends VisitProfileState {
  final String message;
  const VisitProfileError(this.message);
  @override
  List<Object?> get props => [message];
}

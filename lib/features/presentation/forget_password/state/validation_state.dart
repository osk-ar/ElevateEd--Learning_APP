import 'package:equatable/equatable.dart';

class ValidationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ValidationInitial extends ValidationState {}

class ValidationSent extends ValidationState {
  final bool didSend;
  ValidationSent(this.didSend);

  @override
  List<Object?> get props => [didSend];
}

class ValidationError extends ValidationState {
  final String error;
  ValidationError(this.error);

  @override
  List<Object?> get props => [error];
}

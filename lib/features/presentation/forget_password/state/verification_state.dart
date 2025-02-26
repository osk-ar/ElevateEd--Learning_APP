part of 'package:ElevatED/features/presentation/forget_password/cubit/verification_cubit.dart';

class VerificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationLoading extends VerificationState {}

class VerificationVerified extends VerificationState {
  final bool didVerify;
  VerificationVerified({required this.didVerify});

  @override
  List<Object?> get props => [didVerify];
}

class VerificationError extends VerificationState {
  final String error;
  VerificationError({required this.error});

  @override
  List<Object?> get props => [error];
}

class VerificationResentOTP extends VerificationState {
  final String timer;
  VerificationResentOTP({required this.timer});

  @override
  List<Object?> get props => [timer];
}

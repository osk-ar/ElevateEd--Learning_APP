part of 'package:ElevatED/features/presentation/forget_password/cubit/verification_cubit.dart';

class VerificationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class VerificationInitial extends VerificationState {}

class VerificationResentOTP extends VerificationState {
  final String timer;
  VerificationResentOTP({required this.timer});

  @override
  List<Object?> get props => [timer];
}

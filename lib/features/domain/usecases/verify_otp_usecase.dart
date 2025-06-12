import 'package:ElevatED/features/domain/repositories/auth_repository.dart';

class VerifyOtpUsecase {
  final AuthRepository _authRepository;

  VerifyOtpUsecase(this._authRepository);

  Future<bool> call(String email, String otp) async =>
      await _authRepository.verifyOtp(email, otp);
}

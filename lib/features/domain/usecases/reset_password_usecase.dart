import 'package:ElevatED/features/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase {
  final AuthRepository _authRepository;

  ResetPasswordUsecase(this._authRepository);

  Future<bool> call(String email, String newPassword) async =>
      await _authRepository.verifyOtp(email, newPassword);
}

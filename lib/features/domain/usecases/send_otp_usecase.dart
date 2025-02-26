import 'package:ElevatED/features/domain/repo/auth_repository.dart';

class SendOtpUsecase {
  final AuthRepository _authRepository;

  SendOtpUsecase(this._authRepository);

  Future<bool> call(String email) async => await _authRepository.sendOtp(email);
}

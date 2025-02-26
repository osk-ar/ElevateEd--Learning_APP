import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repo/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User> call(User user) async => await _authRepository.login(user);
}

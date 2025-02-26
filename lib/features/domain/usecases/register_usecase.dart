import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repo/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<User> call(User user) async => await _authRepository.register(user);
}

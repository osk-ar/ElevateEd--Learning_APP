import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<UserData> call(User user) async =>
      await _authRepository.login(user.email!, user.password!);
}

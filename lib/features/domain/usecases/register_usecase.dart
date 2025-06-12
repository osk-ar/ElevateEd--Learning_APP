import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  Future<UserData> call(User user) async =>
      await _authRepository.register(user);
}

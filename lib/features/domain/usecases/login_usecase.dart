import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repo/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(User user) async => await repository.login(user);
}

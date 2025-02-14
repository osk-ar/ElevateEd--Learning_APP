import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repo/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<User> call(User user) async => await repository.register(user);
}

import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/repo/auth_repository.dart';

class GoogleAuthUseCase {
  final AuthRepository repository;

  GoogleAuthUseCase(this.repository);

  Future<User?> call() async => await repository.authWithGoogle();
}

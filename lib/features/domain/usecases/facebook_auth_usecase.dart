import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/repo/auth_repository.dart';

class FacebookAuthUseCase {
  final AuthRepository repository;

  FacebookAuthUseCase(this.repository);

  Future<User?> call() async => await repository.authWithFacebook();
}

import 'package:e_learning_app_gp/features/domain/repo/auth_repository.dart';

class UserExistUseCase {
  final AuthRepository repository;

  UserExistUseCase(this.repository);

  Future<bool> call(String email) async => await repository.userExist(email);
}

import 'package:e_learning_app_gp/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register(User user);
  Future<User> login(User user);
}

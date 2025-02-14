import 'package:ElevatED/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register(User user);
  Future<User> login(User user);
}

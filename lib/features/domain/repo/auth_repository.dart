import 'package:e_learning_app_gp/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register(User user);
  Future<User> login(User user);
  Future<bool> userExist(String email);
  Future<User?> authWithGoogle();
  Future<User?> authWithFacebook();
  Future<void> getOTP(String email);
  Future<void> verifyOTP(String email, String code);
  Future<User> otpProfile(String email);
  Future<void> resetPassword(String email, String newPassword);
}

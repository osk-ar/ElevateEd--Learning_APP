import 'package:ElevatED/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register(User user);
  Future<User> login(User user);
  Future<bool> sendOtp(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<bool> resetPassword(String email, String newPassword);
}

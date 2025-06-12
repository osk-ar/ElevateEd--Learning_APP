import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/domain/entities/user.dart';

abstract class AuthRepository {
  Future<UserData> login(String email, String password);
  Future<UserData> register(User user);
  Future<bool> sendOtp(String email);
  Future<bool> verifyOtp(String email, String otp);
  Future<bool> resetPassword(String email, String newPassword);
}

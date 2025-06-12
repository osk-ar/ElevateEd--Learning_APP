import 'package:ElevatED/features/data/models/user_data.dart';

abstract class UserRepository {
  Future<UserData> getUserData(String email, String password);
  Future<UserData> getUserProfile(int userId);
}

import 'package:ElevatED/features/data/data%20sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/data/models/user_login_model.dart';
import 'package:ElevatED/features/domain/repositories/user_repository.dart';

class UserRepositoryImpl extends UserRepository {
  final RemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserData> getUserData(String email, String password) async {
    UserData loginResponse = await remoteDataSource.loginUser(
      UserLoginModel(
        email: email,
        password: password,
      ),
    );
    return loginResponse;
  }

  @override
  Future<UserData> getUserProfile(int userId) async {
    return remoteDataSource.getUserProfile(userId);
  }
}

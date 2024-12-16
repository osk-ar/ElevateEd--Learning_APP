import 'package:e_learning_app_gp/features/data_sources/api/remote_data_source.dart';
import 'package:e_learning_app_gp/features/data_sources/models/auth_response_model.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_login_model.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_register_model.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(User user) async {
    AuthResponseModel loginResponse = await remoteDataSource.loginUser(
      UserLoginModel(
        email: user.email,
        password: user.password,
      ),
    );
    return User(
      id: loginResponse.id,
      userRole: loginResponse.userRole,
    );
  }

  @override
  Future<User> register(User user) async {
    AuthResponseModel registerResponse = await remoteDataSource.registerUser(
      UserRegisterModel(
        userRole: user.userRole,
        fullName: user.fullName,
        phoneNumber: user.phoneNumber,
        birthDate: user.birthDate,
        email: user.email,
        password: user.password,
      ),
    );
    return User(
      id: registerResponse.id,
      userRole: registerResponse.userRole,
    );
  }
}

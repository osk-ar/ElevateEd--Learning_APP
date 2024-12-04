import 'package:e_learning_app_gp/features/data_sources/api/remote_data_source.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_login_model.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_register_model.dart';
import 'package:e_learning_app_gp/features/domain/entities/user.dart';
import 'package:e_learning_app_gp/features/domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(User user) async {
    UserLoginModel userLogin = await remoteDataSource.loginUser(
      UserLoginModel(
        email: user.email,
        password: user.password,
      ),
    );
    return User(
      id: userLogin.id,
      userRole: userLogin.userRole,
      token: userLogin.token,
    );
  }

  @override
  Future<User> register(User user) async {
    UserRegisterModel userData = await remoteDataSource.registerUser(
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
      id: userData.id,
      userRole: userData.userRole,
      token: userData.token,
    );
  }

  @override
  Future<User?> authWithFacebook() {
    // TODO: implement authWithFacebook
    throw UnimplementedError();
  }

  @override
  Future<User?> authWithGoogle() {
    // TODO: implement authWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> getOTP(String email) {
    // TODO: implement getOTP
    throw UnimplementedError();
  }

  @override
  Future<User> otpProfile(String email) {
    // TODO: implement otpProfile
    throw UnimplementedError();
  }

  @override
  Future<bool> userExist(String email) {
    // TODO: implement userExist
    throw UnimplementedError();
  }

  @override
  Future<void> verifyOTP(String email, String code) {
    // TODO: implement verifyOTP
    throw UnimplementedError();
  }

  @override
  Future<void> resetPassword(String email, String newPassword) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}

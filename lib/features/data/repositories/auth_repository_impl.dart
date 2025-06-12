import 'package:ElevatED/features/data/data%20sources/api/remote_data_source.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/data/models/user_login_model.dart';
import 'package:ElevatED/features/data/models/user_register_model.dart';
import 'package:ElevatED/features/domain/entities/user.dart';
import 'package:ElevatED/features/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserData> login(String email, String password) async {
    UserData loginResponse = await remoteDataSource.loginUser(
      UserLoginModel(
        email: email,
        password: password,
      ),
    );
    return loginResponse;
  }

  @override
  Future<UserData> register(User user) async {
    UserData registerResponse = await remoteDataSource.registerUser(
      UserRegisterModel(
        userRole: user.userRole,
        email: user.email,
        password: user.password,
        fullName: user.fullName,
        description: user.description,
        phoneNumber: user.phoneNumber,
        birthDate: user.birthDate,
        interests: user.interests!.map((item) => item.name).toList(),
        // only in instructor
        professionalTitle: user.professionalTitle,
        personalLinks: user.personalLinks,
        profileImage: user.profileImageFile,
      ),
    );
    return registerResponse;
  }

  @override
  Future<bool> sendOtp(String email) async {
    bool didSend = await remoteDataSource.sendOtp(email);

    return didSend;
  }

  @override
  Future<bool> verifyOtp(String email, String otp) async {
    bool didVerify = await remoteDataSource.verifyOtp(email, otp);

    return didVerify;
  }

  @override
  Future<bool> resetPassword(String email, String newPassword) async {
    bool didReset = await remoteDataSource.resetPassword(email, newPassword);

    return didReset;
  }
}

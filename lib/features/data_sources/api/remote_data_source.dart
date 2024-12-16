import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/constants.dart';
import 'package:e_learning_app_gp/features/data_sources/models/auth_response_model.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_login_model.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_register_model.dart';

class RemoteDataSource {
  late Dio dio;

  RemoteDataSource(this.dio);

  ///login by email and password
  Future<AuthResponseModel> loginUser(UserLoginModel user) async {
    try {
      final response = await dio.request(
        '${Constants.baseUrl}auth/login',
        data: user.toJson(),
        options: Options(
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        // empty data
        if (response.data == null) {
          throw Exception("Error happened in request, server returned null");
        }

        // successful
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception("Error happened in request, status code is not 200");
      }
    } catch (error) {
      throw Exception('Error during login: $error');
    }
  }

  ///register by email and password
  Future<AuthResponseModel> registerUser(UserRegisterModel user) async {
    try {
      final response = await dio.request(
        '${Constants.baseUrl}auth/register',
        data: user.toJson(),
        options: Options(
          method: 'POST',
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        // empty data
        if (response.data == null) {
          throw Exception("Error happened in request, server returned null");
        }

        // successful
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception("Error happened in request, status code is not 200");
      }
    } catch (error) {
      throw Exception('Error during registration: $error');
    }
  }
}

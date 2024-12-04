import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/constants.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_login_model.dart';
import 'package:e_learning_app_gp/features/data_sources/models/user_register_model.dart';

class RemoteDataSource {
  late Dio dio;

  RemoteDataSource(this.dio);

  ///login by email and password
  Future<UserLoginModel> loginUser(UserLoginModel user) async {
    try {
      final response = await dio.request(
        '${Constants.baseUrl}auth/emailPassword/login',
        data: user.toJson(),
        options: Options(
          method: 'POST',
        ),
      );
      // print(response.data);
      if (response.statusCode == 200) {
        // successful
        return UserLoginModel.fromJson(response.data["data"]);
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (error) {
      throw Exception('Error during login: $error');
    }
  }

  ///register by email and password
  Future<UserRegisterModel> registerUser(UserRegisterModel user) async {
    // print(1);
    // print(user.toJson().fields);
    try {
      final response = await dio.request(
        '${Constants.baseUrl}auth/emailPassword/register',
        data: user.toJson(),
        options: Options(
          method: 'POST',
        ),
      );

      // print("print: ${response.statusMessage} ,  ${response.data} , ${response.statusCode}");
      if (response.statusCode == 200) {
        // successful
        return UserRegisterModel.fromJson(response.data["data"]);
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (error) {
      print(error);
      throw Exception('Error during registration: $error');
    }
  }
}

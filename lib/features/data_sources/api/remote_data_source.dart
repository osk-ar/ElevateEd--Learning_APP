import 'dart:convert';
import 'dart:developer';

import 'package:ElevatED/features/data_sources/models/auth_response_model.dart';
import 'package:ElevatED/features/data_sources/models/home_response_model.dart';
import 'package:ElevatED/features/data_sources/models/user_login_model.dart';
import 'package:ElevatED/features/data_sources/models/user_register_model.dart';
import 'package:ElevatED/core/constants/constants.dart';
import 'package:dio/dio.dart';

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
        data: await user.toJson(),
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
        log("Success ya Nigm");
        return AuthResponseModel.fromJson(response.data);
      } else {
        throw Exception("Error happened in request, status code is not 200");
      }
    } catch (error) {
      throw Exception('Error during registration: $error');
    }
  }

  // send otp to user email
  Future<bool> sendOtp(String email) async {
    final data = json.encode({"email": email});
    try {
      final response = await dio.request(
        "${Constants.baseUrl}auth/forgot-password",
        options: Options(
          method: 'POST',
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        log("OTP Sent - Data:---- ${response.data}");
        log("OTP Sent - Message:---- ${response.statusMessage}");
        return true;
      } else {
        log("OTP Not Sent Data:---- ${response.data}");
        log("OTP Not Sent Message:---- ${response.data}");
        return false;
      }
    } catch (error) {
      throw Exception('Error during Sending OTP: $error');
    }
  }

  // verify otp
  Future<bool> verifyOtp(String email, String otp) async {
    final String parameters = "?email=$email&otp=$otp";
    try {
      final response = await dio.request(
        "${Constants.baseUrl}auth/verify-otp$parameters",
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        log("OTP Verified - Data:---- ${response.data}");
        log("OTP Verified - Message:---- ${response.statusMessage}");
        return response.data;
      } else {
        log("OTP Not Verified Data:---- ${response.data}");
        log("OTP Not Verified Message:---- ${response.data}");
        return false;
      }
    } catch (error) {
      throw Exception('Error during Verifing OTP: $error');
    }
  }

  // reset password
  Future<bool> resetPassword(String email, String password) async {
    final String parameters = "?email=$email&newPassword=$password";
    try {
      final response = await dio.request(
        "${Constants.baseUrl}auth/reset-password$parameters",
        options: Options(
          method: 'POST',
        ),
      );

      if (response.statusCode == 200) {
        log("Password Reset - Data:---- ${response.data}");
        log("Password Reset - Message:---- ${response.statusMessage}");
        return true;
      } else {
        log("Password Not Reset Data:---- ${response.data}");
        log("Password Not Reset Message:---- ${response.data}");
        return false;
      }
    } catch (error) {
      throw Exception('Error during Password Reseting: $error');
    }
  }

  ///Get Home Data
  Future<HomeResponseModel> getHome(int id) async {
    try {
      final response = await dio.request(
        '${Constants.baseUrl}auth/register/$id',
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
        log("Success ya Nigm Home");
        return HomeResponseModel.fromJson(response.data);
      } else {
        throw Exception("Error happened in request, status code is not 200");
      }
    } catch (error) {
      throw Exception('Error during Get Home: $error');
    }
  }
}

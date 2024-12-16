import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';

class UserRegisterModel {
  final UserRole? userRole;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final DateTime? birthDate;

  UserRegisterModel({
    this.userRole,
    this.fullName,
    this.phoneNumber,
    this.birthDate,
    this.email,
    this.password,
  });

  FormData toJson() {
    return FormData.fromMap({
      'userRole': userRole,
      'firstName': fullName,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate?.toIso8601String(),
      'email': email,
      'password': password,
    });
  }
}

import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';

class UserRegisterModel {
  final String? userRole;
  final String? fullName;
  final String? email;
  final String? password;
  final String? phoneNumber;
  final DateTime? birthDate;
  final String? token;
  final String? id;

  UserRegisterModel({
    this.id,
    this.userRole,
    this.fullName,
    this.phoneNumber,
    this.birthDate,
    this.email,
    this.password,
    this.token,
  });

  factory UserRegisterModel.fromJson(Map<String, dynamic> json) {
    return UserRegisterModel(
      token: json['token'],
      userRole: json['userRole'],
      id: json['userId'],
    );
  }

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

UserRole getUserRoleFromInt(int userRole) {
  switch (userRole) {
    case 0:
      return UserRole.ADMIN;
    case 1:
      return UserRole.STUDENT;
    case 2:
      return UserRole.TEACHER;
    default:
      throw Exception('Invalid rank value');
  }
}

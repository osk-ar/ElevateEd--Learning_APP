import 'package:dio/dio.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';

class UserLoginModel {
  final String? email;
  final String? password;
  final String? token;
  final String? id;
  final String? userRole;

  UserLoginModel(
      {this.id, this.userRole, this.token, this.email, this.password});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      token: json['token'],
      userRole: json['userRole'],
      id: json['userId'],
    );
  }

  FormData toJson() {
    return FormData.fromMap({
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

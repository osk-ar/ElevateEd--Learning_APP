import 'package:e_learning_app_gp/core/constants/enum.dart';

class AuthResponseModel {
  final int? id;
  final UserRole? userRole;

  AuthResponseModel({this.id, this.userRole});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      userRole: json['role'],
      id: json['id'],
    );
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
      throw Exception('Invalid role value');
  }
}

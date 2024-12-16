import 'package:e_learning_app_gp/core/constants/enum.dart';

class UserLoginModel {
  final String? email;
  final String? password;
  final int? id;
  final UserRole? userRole;

  UserLoginModel({this.id, this.userRole, this.email, this.password});

  factory UserLoginModel.fromJson(Map<String, dynamic> json) {
    return UserLoginModel(
      userRole: json['role'],
      id: json['id'],
    );
  }

  Map toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

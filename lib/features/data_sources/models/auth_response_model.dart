import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/map_string_to_user_role.dart';

class AuthResponseModel {
  final int id;
  final UserRole userRole;

  AuthResponseModel({required this.id, required this.userRole});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      userRole: getUserRoleFromString(json['role']),
      id: json['id'],
    );
  }
}

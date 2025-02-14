import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/json_helpers.dart';

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

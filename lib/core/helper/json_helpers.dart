import 'package:ElevatED/core/constants/enum.dart';

UserRole getUserRoleFromString(String userRole) {
  switch (userRole.toUpperCase()) {
    case "STUDENT":
      return UserRole.student;
    case "TEACHER":
      return UserRole.instructor;
    default:
      throw Exception('Invalid role value');
  }
}

String userRoleToString(UserRole role) {
  switch (role) {
    case UserRole.student:
      return "STUDENT";
    case UserRole.instructor:
      return "TEACHER";
  }
}

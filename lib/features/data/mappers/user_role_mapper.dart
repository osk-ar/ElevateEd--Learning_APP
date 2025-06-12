import 'package:ElevatED/core/constants/enum.dart';

class UserRoleMapper {
  UserRoleMapper._();

  static UserRoleEnum stringToEnum(String userRole) {
    switch (userRole.toUpperCase()) {
      case "STUDENT":
        return UserRoleEnum.student;
      case "INSTRUCTOR":
        return UserRoleEnum.instructor;
      default:
        throw Exception('Invalid role value');
    }
  }

  static String enumToString(UserRoleEnum role) {
    switch (role) {
      case UserRoleEnum.student:
        return "STUDENT";
      case UserRoleEnum.instructor:
        return "INSTRUCTOR";
    }
  }
}

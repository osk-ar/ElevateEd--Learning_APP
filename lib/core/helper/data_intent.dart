import 'package:e_learning_app_gp/core/constants/enum.dart';

class DataIntent {
  DataIntent._();

//------------------------------------
  // User Data
  static int? _id;
  static String? _email;
  static String? _password;
  static UserRole? _userRole;
  static String? _fullName;
  static String? _phone;
  static String? _birthDate;
  static UserRole? _role;

  static void pushId(int id) => _id = id;

  static void pushEmail(String email) => _email = email;

  static void pushPassword(String password) => _password = password;

  static void pushUserRole(UserRole userRole) => _userRole = userRole;

  static void pushFullName(String firstName) => _fullName = firstName;

  static void pushBirthDate(String birthDate) => _birthDate = birthDate;

  static void pushPhone(String phone) => _phone = phone;

  static void pushRole(UserRole role) => _role = role;

  static int? getId() => _id;

  static String? getEmail() => _email;

  static String? getPasswordRegister() => _password;

  static UserRole? getUserRole() => _userRole;

  static String? getFullName() => _fullName;

  static String? getPhone() => _phone;

  static String? getBirthDate() => _birthDate;

  static UserRole? getRole() => _role;

//------------------------------------
}

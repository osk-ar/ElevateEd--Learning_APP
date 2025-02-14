import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/domain/entities/home.dart';
import 'package:ElevatED/features/domain/entities/user.dart';

class DataIntent {
  DataIntent._();

//------------------------------------
  // User Data
  static int? _id;
  static UserRole? _userRole;
  static String? _fullName;
  static String? _email;
  static String? _password;
  static String? _phone;
  static String? _birthDate;
  static Home? _homeData;

  static void pushId(int id) => _id = id;

  static void pushEmail(String email) => _email = email;

  static void pushPassword(String password) => _password = password;

  static void pushUserRole(UserRole userRole) => _userRole = userRole;

  static void pushFullName(String firstName) => _fullName = firstName;

  static void pushBirthDate(String birthDate) => _birthDate = birthDate;

  static void pushPhone(String phone) => _phone = phone;

  static void pushHomeData(Home homeData) => _homeData = homeData;

  static int? getId() => _id;

  static String? getEmail() => _email;

  static String? getPassword() => _password;

  static UserRole? getUserRole() => _userRole;

  static String? getFullName() => _fullName;

  static String? getPhone() => _phone;

  static String? getBirthDate() => _birthDate;

  static Home? getHomeData() => _homeData;

//------------------------------------
  static void pushRegisterData(Map<String, dynamic> registerModel) {
    DataIntent.pushUserRole(registerModel['role']!);
    DataIntent.pushEmail(registerModel['email']!);
    DataIntent.pushPassword(registerModel['password']!);
    DataIntent.pushFullName(registerModel['fullName']!);
    DataIntent.pushPhone(registerModel['phone']!);
    DataIntent.pushBirthDate(registerModel['birthDate']!);
  }

  static void pushAuthResponseData(User userModel) {
    DataIntent.pushId(userModel.id!);
    DataIntent.pushUserRole(userModel.userRole!);
  }
}

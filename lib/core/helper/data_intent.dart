import 'package:e_learning_app_gp/core/constants/enum.dart';

class DataIntent {
  DataIntent._();

//------------------------------------
  //register
  static String? _emailRegister;
  static String? _passwordRegister;
  static String? _confirmPasswordRegister;
  static UserRole? _userRoleRegister;
  static String? _firstNameRegister;
  static String? _lastNameRegister;
  static String? _phoneRegister;
  static String? _birthDateRegister;

  static void pushEmailRegister(String email) => _emailRegister = email;

  static void pushPasswordRegister(String password) =>
      _passwordRegister = password;

  static void pushConfirmPasswordRegister(String confirmPassword) =>
      _confirmPasswordRegister = confirmPassword;

  static void pushUserRoleRegister(UserRole userRole) =>
      _userRoleRegister = userRole;

  static void pushFirstNameRegister(String firstName) =>
      _firstNameRegister = firstName;

  static void pushLastNameRegister(String lastName) =>
      _lastNameRegister = lastName;

  static void pushBirthDateRegister(String birthDate) =>
      _birthDateRegister = birthDate;

  static void pushPhoneRegister(String phone) => _phoneRegister = phone;

  static String? getEmailRegister() => _emailRegister;

  static String? getPasswordRegister() => _passwordRegister;

  static String? getConfirmPasswordRegister() => _confirmPasswordRegister;

  static UserRole? getUserRoleRegister() => _userRoleRegister;

  static String? getFirstNameRegister() => _firstNameRegister;

  static String? getLastNameRegister() => _lastNameRegister;

  static String? getPhoneRegister() => _phoneRegister;

  static String? getBirthDateRegister() => _birthDateRegister;

//------------------------------------
  //login to forget password
  static String? _email;

  static void pushEmail(String email) => _email = email;

  static String? popEmail() {
    String? value = _email;
    _email = null;
    return value;
  }

//------------------------------------
  // login-register to All Screens
  static String? _userID;
  static String? _userRole;
  static String? _token;

  static void pushUserID(String userID) {
    _userID = userID;
  }

  static void pushUserRole(String? userRole) {
    _userRole = userRole;
  }

  static void pushToken(String token) {
    _token = token;
  }

  static String? getUserID() {
    return _userID;
  }

  static String? getUserRole() {
    return _userRole;
  }

  static String? getToken() {
    return _token;
  }

  //------------------------------------
  // Home To Start Quiz
  static int? _quizID;

  static void pushQuizID(int? quizID) {
    _quizID = quizID;
  }

  static int? getQuizID() {
    return _quizID;
  }

//------------------------------------
  ///profile data
  static String? _firstName;
  static String? _lastName;
  static String? _description;

  static void pushProfileData({
    String? firstName,
    String? lastName,
    String? description,
    String? profileImage,
    String? coverImage,
  }) {
    _firstName = firstName;
    _lastName = lastName;
    _description = description;
  }

  static String? getFirstName() => _firstName;

  static String? getLastName() => _lastName;

  static String? getDescription() => _description;
//------------------------------------
}

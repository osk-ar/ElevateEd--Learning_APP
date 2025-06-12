class UserLoginModel {
  final String? email;
  final String? password;

  UserLoginModel({this.email, this.password});

  Map toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

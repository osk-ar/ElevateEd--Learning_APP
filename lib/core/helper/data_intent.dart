class DataIntent {
  DataIntent._();

//------------------------------------
  //register
  static String? _emailRegister;

  static void pushEmailRegister(String email) => _emailRegister = email;

  static String? getEmailRegister() => _emailRegister;

//------------------------------------
  //login to forget password
  static String? _email;

  static void pushEmail(String email) => _email = email;

  static String? popEmail() {
    String? value = _email;
    _email = null;
    return value;
  }
}

class Constants {
  // API Constants
  static const String url = 'https://fd10-156-201-85-45.ngrok-free.app';
  static const String baseUrl = '$url/api/';
  static const Duration apiTimeOut = Duration(seconds: 60);
  static const Duration defaultDuration = Duration(milliseconds: 300);
  static const double desktopBreakpoint = 950;
  static const double tabletBreakpoint = 600;
  static const double watchBreakpoint = 300;
  static const int fetchLimit = 10;

  // AppPrefs Constants
  static const String themeKey = "ThemeKey";
  static const String languageKey = "LanguageKey";
  static const String notificationKey = "NotificationKey";
  static const String loginDataKey = "LoginDataKey";
  static const String loginEmailKey = "loginEmailKey";
  static const String loginPasswordKey = "loginPasswordKey";
}

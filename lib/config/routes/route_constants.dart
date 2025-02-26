class Routes {
  Routes._();

  //* Welcome screens
  //todo change "/splash" to "/" to make app start here and make it navigate to home or onBoarding
  static const String splashScreenRoute = "/splash";
  static const String onBoardingScreenRoute = "/onBoarding";

  //* Auth screens
  static const String loginScreenRoute = "/login";
  static const String forgetPasswordValidationScreenRoute =
      "/forgetPasswordValidation";
  static const String forgetPasswordVerificationScreenRoute =
      "/forgetPasswordVerification";
  static const String forgetPasswordChangePasswordScreenRoute =
      "/forgetPasswordChangePassword";
  static const String signupScreenRoute = "/signup";
  static const String signupAsStudentScreenRoute = "/studentSignup";
  static const String signupAsInstructorScreenRoute = "/instructorSignup";

  //* App screens
  static const String mainScreenRoute = "/main";

  static const String homeScreenRoute = "/home";
  static const String statisticsScreenRoute = "/progress";
  static const String coursesScreenRoute = "/courses";
  static const String profileScreenRoute = "/profile";

  static const String courseDetailsScreenRoute = "/courseDetails";
  static const String settingsScreenRoute = "/settings";
  static const String multipleOptionSettingScreenRoute =
      "/multipleOptionSetting";
}

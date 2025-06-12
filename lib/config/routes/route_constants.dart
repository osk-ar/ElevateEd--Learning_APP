class RouteConstants {
  RouteConstants._();

  //* Welcome screens
  //todo change "/splash" to "/" to make app start here and make it navigate to home or onBoarding
  static const String splashScreenRoute = "/";
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

  static const String courseDetailsScreenRoute = "/courseDetails";
  static const String paymentSuccessScreenRoute = "/paymentSuccess";
  static const String paymentCancelScreenRoute = "/paymentCancel";

  static const String settingsScreenRoute = "/settings";
  static const String languageSettingScreenRoute = "/languageOptionSetting";
  static const String themeSettingScreenRoute = "/themeOptionSetting";
  static const String notificationsSettingScreenRoute =
      "/notificationsOptionSetting";
  static const String privacyPolicySettingScreenRoute = "/privacyPolicySetting";
  static const String communityGuidelinesSettingScreenRoute =
      "/communityGuidelinesSetting";

  static const String courseVideoScreenRoute = "/courseVideo";
  static const String profileScreenRoute = "/profile";
  static const String visitProfileScreenRoute = "/visitProfile";
  static const String editProfileScreenRoute = "/editProfile";

  static const String createCourseScreenRoute = "/createCourse";

  static const String addVideoFormRoute = "/addVideoForm";
  static const String addAssignmentFormRoute = "/addAssignmentForm";

  static const String communityScreenRoute = "/community";
  static const String uploadCourseScreenRoute = "/uploadCourse";
}

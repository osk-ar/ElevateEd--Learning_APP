import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:ElevatED/init.dart';
import 'package:ElevatED/main/deep_linking_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final langService = sl<LanguageService>();

  runApp(
    EasyLocalization(
      supportedLocales: langService.locals,
      path: langService.translationsPath,
      fallbackLocale: langService.fallBackLocal,
      startLocale: langService.startLocal,
      useOnlyLangCode: true,
      saveLocale: true,
      child: const AppDeepLinkHandler(),
    ),
  );
}


///! IMPORTANT:
/// 
/// dont forget to clear cache
/// translate the app from splash to end
/// 
/// review all --> view profile, edit profile, visit profile *
/// navigate from course details to instructor visit profile *
/// redirect buy course to success or cancel page
/// navigate from course details to course video , assignment and community
/// fix bug in create course screen selectinga  video gives error

//? tr done for:
/// 1_splash
/// 2_boarding
/// 3_register
/// 4_login
/// 5_forget_password
/// 6_main
/// 7_home
/// 8_createCourse -- //! not done in create_course_screen.dart & pricing validation
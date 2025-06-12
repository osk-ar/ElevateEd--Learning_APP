import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:ElevatED/init.dart';
import 'package:ElevatED/main/app.dart';
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
      child: const AppDeepLinkHandler(child: MyApp()),
    ),
  );
}


/// check for:
///  - Translation
///  - ThemeColor
///  - No layouts used
///  - Api Calls



/// dont forget to clear cache
/// translate the app from splash to end
/// 
/// use new classes:
///   Shared Prefs In services       
///   Cache in data layer

/// change main page to use lazy indexed stack
/// change waterdrop bottomnavbar to a navbar like in figma



//? tr done for:
/// 1_splash
/// 2_boarding
/// 3_register
/// 4_login
/// 5_forget_password
/// 6_main
/// 7_home
/// 8_createCourse -- //! not done in create_course_screen.dart & pricing validation
/// 
/// 
/// profile
/// edit profile
/// api error codes
/// image cropper
/// 




/// 1- get courses
/// 2- get course details
/// 3- buy course
/// 4- update course details to view
/// 5- watch course
/// TODO: review all --> view profile, edit profile, visit profile 
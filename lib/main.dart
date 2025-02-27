import 'dart:ui';

import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/routes/router.dart';
import 'package:ElevatED/config/themes/theme_data.dart';
import 'package:ElevatED/core/dependency_injection.dart';
import 'package:ElevatED/core/helper/theme_helpers.dart';
import 'package:ElevatED/core/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themed/themed.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

late final WidgetsBinding engine;

void main() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsBinding.instance;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await init();
  ThemeHelpers themeHelpers = sl<ThemeHelpers>();
  PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
    themeHelpers.getCurrentTheme();
  };

  // Record Crashes to Firebase Crashlytics
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    FlutterError.dumpErrorToConsole(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Only allow portrait orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(
    EasyLocalization(
      supportedLocales: AppLanguages.locals,
      path: AppLanguages.translationsPath,
      fallbackLocale: AppLanguages.fallBackLocal,
      startLocale: AppLanguages.startLocal,
      useOnlyLangCode: true,
      saveLocale: true,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final ThemeHelpers themeHelpers = sl<ThemeHelpers>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Themed(
        currentTheme: themeHelpers.getCurrentTheme(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ElevateEd',
          themeMode: ThemeMode.system,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashScreenRoute,
        ),
      ),
    );
  }
}



///* recap
/// auth request has profile
/// home request  has stats
/// courses request has courses and categories
/// 
/// use memory cache
/// dont forget to clear cache
// todo dont forget to add billing_details, reset_password, notificatinos, logout options in settings 
// todo revise on auth to make sure its complete and functional with remon
// todo remake home ui, progress ui
// todo translate the WHOLE app
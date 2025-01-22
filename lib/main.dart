import 'dart:ui';

import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/routes/router.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/config/themes/theme_data.dart';
import 'package:e_learning_app_gp/core/dependency_injection.dart';
import 'package:e_learning_app_gp/core/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themed/themed.dart';

late final WidgetsBinding engine;

void main() async {
  // ElevateEd
  engine = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: engine);
  await EasyLocalization.ensureInitialized();
  await init();
  PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    if (brightness == Brightness.light) {
      Themed.currentTheme = lightTheme;
    } else {
      Themed.currentTheme = darkTheme;
    }
  };
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
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
  final brightness =
      SchedulerBinding.instance.platformDispatcher.platformBrightness;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Themed(
        currentTheme: brightness == Brightness.light ? lightTheme : darkTheme,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'ElevateEd',
          themeMode: ThemeMode.system,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashScreenRoute,
        ),
      ),
    );
  }
}


//? 2hrs        -> change text select color to secondary color
//? 2hrs        -> fix role button in register page
//? 4hrs        -> fix themes & clean project
//? 1/4day      -> create student register page
//? 1/4day      -> create instructor register page
//? 15min       -> send request shape to remon
//? 1day        -> create cubit - repo - usecase - request = for register
//? 1/4day      -> create sharedPrefs for auth creds
// TODO 1day    -> modify progress screen from baioumy
// TODO 15min   -> send progress screen request shape to remon
// TODO 1day    -> create cubit - repo - usecase - request = for progress
//* Total sum to: 3.75 days | 2.5 hrs ~= 1 week
//// Extras
// TODO -> fix ui doesn't build when navigating thru screens in register & login
// TODO -> instead of multiple cubit calls (context.read<>()...) in blocBuilders create a final cubit = context.read<>(); then take values from it
// TODO -> add forget password & email verification to auth

///* recap
/// use 1 state and a state.copyWith to emit new states
/// use blocSelector to listen to a specific variable change in the state then rebuild
/// split cubit into state and ui component
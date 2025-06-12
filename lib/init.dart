import 'dart:ui';
import 'package:ElevatED/core/services/theme%20service/theme_services.dart';
import 'package:ElevatED/dependency_injection.dart';
import 'package:ElevatED/config/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;
late final WidgetsBinding engine;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> init() async {
  engine = WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await firebaseInit();
  await dotenv.load(fileName: ".env");
  await registerDependencies();
  themeInit();
}

void themeInit() {
  ThemeService themeService = sl<ThemeService>();
  themeService.init();
}

Future<void> firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Record Crashes to Firebase Crashlytics
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    FlutterError.dumpErrorToConsole(details);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
}

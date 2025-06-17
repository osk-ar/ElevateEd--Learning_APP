import 'dart:developer';
import 'dart:ui';
import 'package:ElevatED/core/services/notification%20services/fcm_notification.dart';
import 'package:ElevatED/core/services/theme%20service/theme_services.dart';
import 'package:ElevatED/dependency_injection.dart';
import 'package:ElevatED/config/firebase_options.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  sl<FcmNotification>().initNotifications();
}

void themeInit() {
  ThemeService themeService = sl<ThemeService>();
  themeService.init();
}

// This handler must be a top-level function (outside of any class)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  log("Handling a background message: ${message.messageId}");
}

Future<void> firebaseInit() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

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

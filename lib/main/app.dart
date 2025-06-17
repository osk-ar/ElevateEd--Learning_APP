import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/routes/route_generator.dart';
import 'package:ElevatED/config/themes/theme_data.dart';
import 'package:ElevatED/core/services/Language%20Service/language_service.dart';
import 'package:ElevatED/core/services/theme%20service/theme_services.dart';
import 'package:ElevatED/init.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:themed/themed.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    sl<LanguageService>().init(context);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => Themed(
        currentTheme: sl<ThemeService>().getThemeData(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: 'ElevateEd',
          theme: lightThemeData,
          darkTheme: darkThemeData,
          themeMode: ThemeMode.system,
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: RouteConstants.splashScreenRoute,
        ),
      ),
    );
  }
}

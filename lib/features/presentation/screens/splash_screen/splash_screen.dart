import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/default_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
        const Duration(seconds: 1),
        () {
          print("Splash Passed");
          FlutterNativeSplash.remove();
          context.pushNamed(Routes.onBoardingScreenRoute);
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
      child: Center(),
    );
  }
}

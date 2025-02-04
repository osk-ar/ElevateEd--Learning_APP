import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_layout.dart';
import 'package:e_learning_app_gp/features/presentation/splash/cubits/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool isSignedIn = await context.read<SplashCubit>().checkSharedPrefs();

      FlutterNativeSplash.remove();
      if (isSignedIn) {
        if (context.mounted) {
          context.pushNamed(Routes.mainScreenRoute);
        }
      } else {
        if (context.mounted) {
          context.pushNamed(Routes.onBoardingScreenRoute);
        }
      }

      Future.delayed(
        const Duration(seconds: 1),
        () {
          print("Splash Passed");
        },
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.backgroundColor,
      body: DefaultLayout(
        child: Center(),
      ),
    );
  }
}

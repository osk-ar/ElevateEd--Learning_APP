import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/splash/cubits/splash_cubit.dart';
import 'package:ElevatED/features/presentation/common/rotating_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      FlutterNativeSplash.remove();

      await Future.delayed(
        const Duration(seconds: 3),
        () {
          print("Splash Passed");
        },
      );
      if (!context.mounted) {
        return;
      }

      bool isSignedIn = await context.read<SplashCubit>().checkSharedPrefs();
      if (!context.mounted) {
        return;
      }

      if (isSignedIn) {
        context.pushNamed(Routes.mainScreenRoute);
      } else {
        context.pushNamed(Routes.onBoardingScreenRoute);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ThemeColors.backgroundColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: context.width, height: 155.h),
            const DoubleCircularAvatar(
                child: RotatingLogo(
              isInfiniteRotation: false,
            )),
            SizedBox(height: 436.h),
            Text(
              "ElevatED",
              style: getMediumStyle(fontSize: 16, color: ThemeColors.textColor),
            ),
          ],
        ));
  }
}

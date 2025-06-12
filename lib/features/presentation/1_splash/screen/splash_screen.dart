import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/1_splash/cubits/splash_cubit.dart';
import 'package:ElevatED/features/presentation/0_common/rotating_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));
      if (!context.mounted) return;
      await _handleNavigation();
    });
  }

  Future<void> _handleNavigation() async {
    final splashCubit = context.read<SplashCubit>();
    final bool isAuthorized = await splashCubit.checkSharedPrefs();
    if (!mounted) return;

    String route = isAuthorized
        ? RouteConstants.mainScreenRoute
        : RouteConstants.onBoardingScreenRoute;

    context.pushNamed(route);
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

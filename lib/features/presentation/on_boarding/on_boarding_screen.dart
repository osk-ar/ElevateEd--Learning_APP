import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/on_boarding/widgets/custom_animated_widget.dart';
import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.centerLeft,
                colors: [
              AppColors.fadedPrimaryColor,
              ThemeColors.backgroundColor,
              ThemeColors.backgroundColor,
              ThemeColors.backgroundColor,
            ])),
        child: Column(
          children: [
            SizedBox(height: 48.h),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: getLightStyle(
                    color: ThemeColors.textColor,
                    fontSize: 32.sp,
                  ),
                  children: [
                    const TextSpan(text: "Build "),
                    TextSpan(
                      text: "Learning\n",
                      style: getBoldStyle(
                        color: MyTheme.tempPrimary,
                        fontSize: 32.sp,
                      ),
                    ),
                    const TextSpan(text: "As Good Habit\n to "),
                    TextSpan(
                      text: "Improve Skills!",
                      style: getBoldStyle(
                        color: MyTheme.tempPrimary,
                        fontSize: 32.sp,
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: 20.h),
            const CustomAnimatedWidget(),
            SizedBox(height: 20.h),
            CTAButton(
              text: "Start Learning!",
              onPressed: () {
                context.pushNamed(Routes.signupScreenRoute);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account?",
                  style: getRegularStyle(
                    fontSize: 14.sp,
                    color: ThemeColors.textColor,
                  ),
                ),
                TextButton(
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () {
                    context.pushNamed(Routes.loginScreenRoute);
                  },
                  child: Text(
                    "Sign in",
                    style: getSemiBoldStyle(
                      fontSize: 14.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// TODO ---> add login & register navigation functions

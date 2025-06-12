import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/presentation/2_on_boarding/widgets/custom_animated_widget.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
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
                    TextSpan(text: AppStrings.build),
                    TextSpan(
                      text: "${AppStrings.learning}\n",
                      style: getBoldStyle(
                        color: MyTheme.tempPrimary,
                        fontSize: 32.sp,
                      ),
                    ),
                    TextSpan(text: "${AppStrings.asGoodHabitTo}\n"),
                    TextSpan(
                      text: AppStrings.improveSkills,
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
              text: AppStrings.startLearning,
              onPressed: () {
                context.pushNamed(RouteConstants.signupScreenRoute);
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.alreadyHaveAnAccount,
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
                    context.pushNamed(RouteConstants.loginScreenRoute);
                  },
                  child: Text(
                    AppStrings.signIn,
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

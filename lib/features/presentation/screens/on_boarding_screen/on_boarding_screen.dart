import 'package:flutter/material.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/image_handler.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/core/resources/assets_manager.dart';
import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/default_layout.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      topPadding: 64,
      bottomPadding: 24,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              style: AppTextStyles.onBoardingLightTextStyle(context),
              children: [
                const TextSpan(text: "Build "),
                TextSpan(
                    text: "Learning\n",
                    style: AppTextStyles.onBoardingBoldTextStyle(context)),
                const TextSpan(text: "As Good Habit\n to "),
                TextSpan(
                    text: "Improve Skills!",
                    style: AppTextStyles.onBoardingBoldTextStyle(context)),
              ]),
        ),
        const Spacer(),
        const ImageManager(
          url: LottieAssets.cup,
          width: 240,
          height: 240,
        ),
        const Spacer(),
        CustomButton(
          color: MyTheme.primaryColor,
          colorText: MyTheme.inverseTextColor,
          text: "Start Learning!",
          onPressed: () {
            context.pushNamed(Routes.signupScreenRoute);
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account?",
                style: AppTextStyles.semiBoldHintTextStyle(context)),
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
                style: AppTextStyles.textButtonTextStyle(context),
              ),
            ),
          ],
        )
      ],
    );
  }
}

// TODO ---> add login & register navigation functions

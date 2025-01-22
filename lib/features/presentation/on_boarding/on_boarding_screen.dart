import 'package:e_learning_app_gp/features/presentation/common/layouts/default_gradient_layout.dart';
import 'package:e_learning_app_gp/features/presentation/on_boarding/widgets/custom_animated_widget.dart';
import 'package:flutter/material.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/features/presentation/common/custom_button.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultGradientLayout(
      topPadding: 64,
      bottomPadding: 24,
      gradient: const LinearGradient(
        begin: AlignmentDirectional.bottomCenter,
        end: AlignmentDirectional.topCenter,
        tileMode: TileMode.decal,
        transform: GradientRotation(180),
        colors: [
          MyTheme.backgroundGradientColor,
          MyTheme.backgroundColor,
          MyTheme.backgroundColor,
        ],
      ),
      child: Column(
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
                style: AppTextStyles.lightTextStyle(
                  context,
                  color: MyTheme.textColor,
                  fontSize: 36,
                ),
                children: [
                  const TextSpan(text: "Build "),
                  TextSpan(
                    text: "Learning\n",
                    style: AppTextStyles.boldTextStyle(
                      context,
                      color: MyTheme.primaryColor,
                      fontSize: 36,
                    ),
                  ),
                  const TextSpan(text: "As Good Habit\n to "),
                  TextSpan(
                    text: "Improve Skills!",
                    style: AppTextStyles.boldTextStyle(
                      context,
                      color: MyTheme.primaryColor,
                      fontSize: 36,
                    ),
                  ),
                ]),
          ),
          const SizedBox(height: 20),
          const CustomAnimatedWidget(),
          const SizedBox(height: 20),
          CustomButton(
            color: MyTheme.primaryColor,
            colorText: Colors.white,
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
      ),
    );
  }
}

// TODO ---> add login & register navigation functions

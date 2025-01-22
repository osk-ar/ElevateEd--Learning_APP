import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: () {
        print("Forget Password Clicked!");
      },
      child: Text(
        "forget password?",
        style: AppTextStyles.mediumTextStyle(context,
            color: MyTheme.primaryColor, fontSize: FontSize.f14),
      ),
    );
  }
}


/*
    GestureDetector(
      onTap: () {
        DataIntent.pushEmail(context.read<LoginCubit>().emailController.text);
        context.pushNamed(Routes.onBoardingScreenRoute);
      },
      child: Text(
        "forgot password?",
        style: AppTextStyles.lightTextStyle(context),
      ),
    );
 */
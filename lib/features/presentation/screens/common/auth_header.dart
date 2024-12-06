import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final bool isLogin;
  const Header({
    super.key,
    this.isLogin = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          isLogin ? "Welcome Back!" : "Hello There!",
          style: AppTextStyles.customButtonTextStyle(context,
              fontSize: FontSize.f36, color: MyTheme.textColor),
        ),
        Text(
          isLogin ? "You have been missed" : "Create a new account",
          style: AppTextStyles.mediumTextStyle(context,
              fontSize: FontSize.f16,
              color: MyTheme.textColor.withOpacity(0.6)),
        ),
      ],
    );
  }
}

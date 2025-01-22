import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  final String subTitle;
  const Header({
    super.key,
    required this.title,
    required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          style: AppTextStyles.customButtonTextStyle(context,
              fontSize: FontSize.f36, color: MyTheme.textColor),
        ),
        Text(
          subTitle,
          style: AppTextStyles.mediumTextStyle(context,
              fontSize: FontSize.f16,
              color: MyTheme.textColor.withOpacity(0.6)),
        ),
      ],
    );
  }
}

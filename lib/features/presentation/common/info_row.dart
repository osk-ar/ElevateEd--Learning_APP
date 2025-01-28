import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({super.key, required this.title, required this.value});
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: getSemiBoldStyle(fontSize: 16, color: MyTheme.textColor),
        ),
        Text(
          value,
          style: getMediumStyle(fontSize: 14, color: MyTheme.primaryColor),
        ),
      ],
    );
  }
}

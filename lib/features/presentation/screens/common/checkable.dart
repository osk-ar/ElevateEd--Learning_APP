import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';

class Checkable extends StatefulWidget {
  const Checkable({super.key});

  @override
  State<Checkable> createState() => _CheckableState();
}

class _CheckableState extends State<Checkable> {
  bool? check = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: MyTheme.primaryColor,
            value: check,
            onChanged: (val) {
              setState(() {
                check = val;
              });
            }),
        Text(
          "Remember me",
          style: AppTextStyles.lightTextStyle(context, fontSize: FontSize.f14),
        ),
      ],
    );
  }
}

import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          style: getSemiBoldStyle(fontSize: 32.sp, color: MyTheme.textColor),
        ),
        Text(
          subTitle,
          style: getMediumStyle(
              fontSize: 16.sp, color: MyTheme.textColor.withOpacity(0.6)),
        ),
      ],
    );
  }
}

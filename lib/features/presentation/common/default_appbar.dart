import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget? defaultAppbar(String title) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: ThemeColors.textColor,
    surfaceTintColor: Colors.transparent,
    title: Text(
      title,
      style: getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
    ),
  );
}

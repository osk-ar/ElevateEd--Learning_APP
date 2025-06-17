import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget defaultAppbar(String title, {bool showBackButton = true}) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: ThemeColors.textColor,
    surfaceTintColor: Colors.transparent,
    title: Text(
      title,
      style: getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
    ),
    leading: showBackButton ? null : const SizedBox.shrink(),
  );
}

SliverAppBar defaultSliverAppbar(String title) {
  return SliverAppBar(
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

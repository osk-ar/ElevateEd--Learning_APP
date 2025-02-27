import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SettingTile extends StatelessWidget {
  const SettingTile(
      {super.key,
      required this.title,
      required this.onTap,
      required this.iconPath,
      required this.foregroundColor});
  final String title;
  final void Function()? onTap;
  final String iconPath;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ThemeColors.lightSurfaceToDarkSecondary,
      iconColor: foregroundColor,
      textColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      leading: SvgPicture.asset(iconPath, width: 24.r, height: 24.r),
      title: Text(
        title,
        style: getMediumStyle(
          fontSize: 14.sp,
          color: foregroundColor,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16.r,
      ),
      onTap: onTap,
    );
  }
}

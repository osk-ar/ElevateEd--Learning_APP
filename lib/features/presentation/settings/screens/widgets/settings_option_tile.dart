import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingOptionTile extends StatelessWidget {
  const SettingOptionTile({
    super.key,
    required this.title,
    required this.onTap,
    required this.isSelected,
    required this.foregroundColor,
  });
  final String title;
  final bool isSelected;
  final Color foregroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ThemeColors.lightSurfaceToDarkSecondary,
      iconColor: foregroundColor,
      textColor: foregroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      title: Text(
        title,
        style: getMediumStyle(
          fontSize: 14.sp,
          color: foregroundColor,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_rounded,
              size: 24.r,
            )
          : null,
      onTap: onTap,
    );
  }
}

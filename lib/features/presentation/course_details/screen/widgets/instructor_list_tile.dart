import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorListTile extends StatelessWidget {
  const InstructorListTile(
      {super.key, required this.instructorName, required this.onPressed});
  final String instructorName;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: ThemeColors.secondaryColor,
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(42.r),
      ),
      leading: CircleAvatar(
        radius: 25.r,
        backgroundColor: ThemeColors.backgroundColor,
        child: Text(
          instructorName[0].toUpperCase(),
          style: getMediumStyle(
            fontSize: 14.sp,
            color: ThemeColors.textColor,
          ),
        ),
      ),
      title: Text(
        instructorName,
        style: TextStyle(fontSize: 16.sp),
      ),
      trailing: IconButton(
        style: IconButton.styleFrom(
          backgroundColor: ThemeColors.lightSurfaceToDarkSecondary,
        ),
        onPressed: onPressed,
        icon: const Icon(Icons.arrow_forward),
      ),
    );
  }
}

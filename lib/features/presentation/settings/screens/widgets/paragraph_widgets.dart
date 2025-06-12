import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
    child: Text(
      title,
      style: getBoldStyle(fontSize: 20.sp, color: ThemeColors.textColor),
    ),
  );
}

Widget subSectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
    child: Text(
      title,
      style: getBoldStyle(fontSize: 18.sp, color: ThemeColors.textColor),
    ),
  );
}

Widget textBody(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: getRegularStyle(fontSize: 16.sp, color: ThemeColors.textColor),
    ),
  );
}

Widget bulletPoint(String text) {
  return Padding(
    padding: EdgeInsets.only(left: 16.h, bottom: 4.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: getRegularStyle(fontSize: 16.sp, color: ThemeColors.textColor),
        ),
        Expanded(
            child: Text(
          text,
          style: getRegularStyle(fontSize: 16.sp, color: ThemeColors.textColor),
        )),
      ],
    ),
  );
}

import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HintWidget extends StatelessWidget {
  const HintWidget(this.hint, {super.key});

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8.w),
      child: Text(
        hint,
        style: getRegularStyle(
          fontSize: 12.sp,
          color: AppColors.whiteColor.withAlpha(175),
        ),
      ),
    );
  }
}

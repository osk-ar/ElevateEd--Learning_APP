import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_sizes.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryCtaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final FocusNode? focusNode;
  const SecondaryCtaButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300.w,
      height: 40.h,
      child: ElevatedButton(
        focusNode: focusNode,
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          splashFactory: InkRipple.splashFactory,
          elevation: 0,
          backgroundColor: ThemeColors.secondaryColor,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppOddSizes.medium.r),
              side: BorderSide(width: 1.w, color: AppColors.primaryColor)),
        ),
        child: Text(
          text,
          style:
              getSemiBoldStyle(fontSize: 14.sp, color: ThemeColors.textColor),
        ),
      ),
    );
  }
}

import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/core/resources/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CTAButton extends StatelessWidget {
  const CTAButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.focusNode,
  });

  final String text;
  final VoidCallback onPressed;
  final double? width;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 300.w,
      height: 50.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              AppColors.primaryColor,
              AppColors.primaryGradientColor_1,
              AppColors.primaryColor,
              AppColors.primaryGradientColor_2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppOddSizes.medium.r),
        ),
        child: ElevatedButton(
          focusNode: focusNode,
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppOddSizes.medium.r),
            ),
          ),
          child: Text(
            text,
            style: getSemiBoldStyle(
                fontSize: 16.sp, color: ThemeColors.inverseTextColor),
          ),
        ),
      ),
    );
  }
}

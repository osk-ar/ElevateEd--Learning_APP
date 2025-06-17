import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CTAButton extends StatelessWidget {
  const CTAButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.focusNode,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final FocusNode? focusNode;
  final bool isLoading;

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
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: ElevatedButton(
          focusNode: focusNode,
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            splashFactory: InkRipple.splashFactory,
            elevation: 0,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.r,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      ThemeColors.inverseTextColor,
                    ),
                  ),
                )
              : Text(
                  text,
                  style: getSemiBoldStyle(
                    fontSize: 16.sp,
                    color: ThemeColors.inverseTextColor,
                  ),
                ),
        ),
      ),
    );
  }
}

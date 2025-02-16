import 'dart:io';

import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomSuccessSheet extends StatelessWidget {
  const BottomSuccessSheet({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime? lastBackPressed;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        DateTime now = DateTime.now();
        if (lastBackPressed == null ||
            now.difference(lastBackPressed!) > const Duration(seconds: 4)) {
          lastBackPressed = now;
          context.message(message: "Press back again to leave the app");
        } else {
          exit(0);
        }
      },
      child: Column(
        children: [
          SizedBox(
            height: 64.h,
            width: double.infinity,
          ),
          Icon(
            Icons.check_circle_rounded,
            color: AppColors.primaryColor,
            size: 85.r,
          ),
          SizedBox(height: 36.h),
          Text(
            "Password Changed Successfully",
            style: getMediumStyle(fontSize: 16.sp, color: AppColors.whiteColor),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Text(
              textAlign: TextAlign.center,
              "Congratulations! Your password has changed successfully. You can go to the home page directly from the button below.",
              style: getRegularStyle(
                  fontSize: 14.sp, color: AppColors.darkSubColor),
            ),
          ),
          const Spacer(),
          CTAButton(text: "Go To Home", onPressed: () {}),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}

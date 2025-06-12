import 'dart:io';

import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
          context.message(message: "press_back_again_to_leave_the_app".tr());
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
            "password_changed_successfully".tr(),
            style: getMediumStyle(fontSize: 16.sp, color: AppColors.whiteColor),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 26.w),
            child: Text(
              textAlign: TextAlign.center,
              "congratulations_your_password_has_changed_successfully_you_can_go_to_the_home_page_directly_from_the_button_below_"
                  .tr(),
              style: getRegularStyle(
                  fontSize: 14.sp, color: AppColors.darkSubColor),
            ),
          ),
          const Spacer(),
          CTAButton(text: "go_to_home".tr(), onPressed: () {}),
          SizedBox(height: 60.h),
        ],
      ),
    );
  }
}

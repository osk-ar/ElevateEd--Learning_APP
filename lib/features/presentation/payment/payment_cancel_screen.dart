import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentCancelScreen extends StatelessWidget {
  const PaymentCancelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel_outlined,
                size: 120.w,
                color: AppColors.warningColor,
              ),
              SizedBox(height: 24.h),
              Text(
                AppStrings.paymentCancelled,
                style: getBoldStyle(
                  fontSize: 24.sp,
                  color: ThemeColors.textColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.paymentCancelMessage,
                textAlign: TextAlign.center,
                style: getRegularStyle(
                  fontSize: 16.sp,
                  color: ThemeColors.subTextColor,
                ),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () {
                    // Navigate back to course details
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteConstants.homeScreenRoute,
                      (route) => false,
                    );
                  },
                  child: Text(
                    AppStrings.returnToCourse,
                    style: getRegularStyle(
                      fontSize: 16.sp,
                      color: ThemeColors.textColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

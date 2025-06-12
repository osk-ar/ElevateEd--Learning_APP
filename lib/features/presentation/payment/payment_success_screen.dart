import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final int courseId;
  const PaymentSuccessScreen({super.key, required this.courseId});

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
                Icons.check_circle_outline,
                size: 120.w,
                color: AppColors.successColor,
              ),
              SizedBox(height: 24.h),
              Text(
                AppStrings.paymentSuccessful,
                style: getBoldStyle(
                  fontSize: 24.sp,
                  color: ThemeColors.textColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                AppStrings.paymentSuccessMessage,
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
                    // Navigate to course details and then to first video
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteConstants.courseDetailsScreenRoute,
                      (route) => false,
                      arguments: courseId,
                    );
                  },
                  child: Text(
                    AppStrings.startLearning,
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

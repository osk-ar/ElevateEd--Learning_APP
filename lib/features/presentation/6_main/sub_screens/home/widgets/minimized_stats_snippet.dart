import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class MinimizedStatsSnippetWithProgressIndicator extends StatelessWidget {
  const MinimizedStatsSnippetWithProgressIndicator(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      required this.valueExtention,
      required this.progressValue});
  final String title;
  final String value;
  final String valueExtention;
  final IconData icon;
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 103.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ThemeColors.lightSurfaceToDarkSecondary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: AppColors.primaryColor,
                size: 36.r,
              ),
              Text(
                title,
                style: getMediumStyle(
                    fontSize: 14.sp, color: AppColors.whiteColor),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: value,
                        style: getSemiBoldStyle(
                            fontSize: 14.sp, color: AppColors.whiteColor)),
                    TextSpan(
                        text: "  $valueExtention",
                        style: getRegularStyle(
                            fontSize: 14.sp, color: AppColors.whiteColor)),
                  ],
                ),
              ),
              CircularProgressIndicator(
                backgroundColor: ThemeColors.backgroundColor,
                color: AppColors.inversePrimaryColor,
                value: progressValue,
                strokeWidth: 4.w,
                strokeCap: StrokeCap.round,
              )
            ],
          )
        ],
      ),
    );
  }
}

class MinimizedStatsSnippet extends StatelessWidget {
  const MinimizedStatsSnippet({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.valueExtention,
  });
  final String title;
  final String value;
  final String valueExtention;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      height: 103.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ThemeColors.lightSurfaceToDarkSecondary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                icon,
                color: AppColors.primaryColor,
                size: 36.r,
              ),
              Text(
                title,
                style: getMediumStyle(
                    fontSize: 14.sp, color: AppColors.whiteColor),
              ),
            ],
          ),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                TextSpan(
                    text: value,
                    style: getSemiBoldStyle(
                        fontSize: 14.sp, color: AppColors.whiteColor)),
                TextSpan(
                    text: "  $valueExtention",
                    style: getRegularStyle(
                        fontSize: 14.sp, color: AppColors.whiteColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

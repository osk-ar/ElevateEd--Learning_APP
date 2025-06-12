import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/data/models/data_point.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/widgets/bar_chart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class HomeProgressSnippet extends StatelessWidget {
  final List<DataPoint> progressPoints;
  final int totalRecentProgress;
  final String title;
  final String valueExtention;

  const HomeProgressSnippet({
    super.key,
    required this.progressPoints,
    required this.totalRecentProgress,
    required this.title,
    required this.valueExtention,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 192.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: ThemeColors.lightSurfaceToDarkSecondary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: getSemiBoldStyle(
                    color: AppColors.whiteColor, fontSize: 16.sp),
              ),
              const SizedBox(),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: totalRecentProgress.toString(),
                      style: getSemiBoldStyle(
                          color: AppColors.whiteColor, fontSize: 24.sp),
                    ),
                    TextSpan(
                      text: valueExtention,
                      style: getRegularStyle(
                          color: AppColors.whiteColor, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Text(
                AppStrings.trackYourProgressHere,
                style: getLightStyle(
                    color: AppColors.inversePrimaryColor, fontSize: 14.sp),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            spacing: 8.h,
            children: [
              Text(
                AppStrings.last3Days,
                style: getRegularStyle(
                    color: AppColors.whiteColor, fontSize: 14.sp),
              ),
              SizedBox(
                height: 120.h,
                width: 100.w,
                child: CustomBarChart(
                  titleHeight: 20.h,
                  titlesTopMargin: 4.h,
                  toolTipMargin: 0,
                  barData:
                      progressPoints.map((point) => point.value + 1).toList(),
                  width: 24.w,
                  radius: 8.r,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

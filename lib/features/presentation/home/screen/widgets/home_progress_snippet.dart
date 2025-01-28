import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:e_learning_app_gp/features/presentation/common/bar_char.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class HomeProgressSnippet extends StatelessWidget {
  const HomeProgressSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 192.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MyTheme.surfaceColor,
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
                "Recently Progress",
                style:
                    getSemiBoldStyle(color: MyTheme.textColor, fontSize: 16.sp),
              ),
              const SizedBox(),
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "17",
                      style: getSemiBoldStyle(
                          color: MyTheme.textColor, fontSize: 24.sp),
                    ),
                    TextSpan(
                      text: " Hrs",
                      style: getRegularStyle(
                          color: MyTheme.hintTextColor, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              Text(
                "Track your progress here",
                style: getLightStyle(
                    color: MyTheme.hintTextColor, fontSize: 14.sp),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Last 3 days",
                style: getRegularStyle(
                    color: MyTheme.hintTextColor, fontSize: 14.sp),
              ),
              SizedBox(height: 8.h),
              SizedBox(
                height: 120.h,
                width: 100.w,
                child: CustomBarChart(
                  titleHeight: 20.h,
                  titlesBarSpacer: 4.h,
                  toolTipMargin: 0,
                  barData: const [5, 9, 3],
                  titles: const ["Th", "Fr", "Sa"],
                  width: 24.w,
                  radius: 4.r,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

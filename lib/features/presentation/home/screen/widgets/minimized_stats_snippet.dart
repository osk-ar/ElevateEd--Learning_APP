import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';

class MinimizedStatsSnippet extends StatelessWidget {
  const MinimizedStatsSnippet(
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
      width: 170.w,
      height: 118.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: MyTheme.surfaceColor,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: MyTheme.primaryColor,
                size: 32.r,
              ),
              SizedBox(width: 8.h),
              Text(
                title,
                style: TextStyle(
                  color: MyTheme.textColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
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
                        style: getBoldStyle(
                            fontSize: 16, color: MyTheme.textColor)),
                    TextSpan(
                        text: "  $valueExtention",
                        style: getMediumStyle(
                            fontSize: 14, color: MyTheme.hintTextColor)),
                  ],
                ),
              ),
              CircularProgressIndicator(
                backgroundColor: MyTheme.secondaryColor,
                color: MyTheme.primaryColor,
                value: progressValue,
                semanticsLabel: "Hellr",
                semanticsValue: "yo yo yo",
                strokeWidth: 6,
              )
            ],
          )
        ],
      ),
    );
  }
}

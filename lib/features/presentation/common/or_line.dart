import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/core/resources/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrLine extends StatelessWidget {
  const OrLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: 140.w,
          height: (1.5).h,
          color: MyTheme.labelTextColor,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppEvenSizes.medium.w),
          child: Text(
            "OR",
            style:
                getRegularStyle(color: MyTheme.labelTextColor, fontSize: 16.sp),
          ),
        ),
        Container(
          width: 140.w,
          height: (1.5).h,
          color: MyTheme.labelTextColor,
        ),
      ],
    );
  }
}

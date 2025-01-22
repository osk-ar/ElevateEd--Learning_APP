import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
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
          width: AppSize.s140.w,
          height: AppSize.s1_5.h,
          color: MyTheme.labelTextColor,
        ),
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.defaultPadding.w),
          child: Text(
            "OR",
            style: AppTextStyles.regularTextStyle(context,
                color: MyTheme.labelTextColor, fontSize: FontSize.f16),
          ),
        ),
        Container(
          width: AppSize.s140.w,
          height: AppSize.s1_5.h,
          color: MyTheme.labelTextColor,
        ),
      ],
    );
  }
}

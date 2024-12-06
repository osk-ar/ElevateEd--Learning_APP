import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

CheckboxThemeData checkboxThemeData = CheckboxThemeData(
  checkColor: WidgetStateProperty.all(Colors.white),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(AppBorderRadius.semiBigBorderRadius.r / 2),
    ),
  ),
  side: const BorderSide(color: AppColors.whiteColor40),
);

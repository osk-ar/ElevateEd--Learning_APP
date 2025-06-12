import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: MyTheme.surfaceColor,
  filled: true,
  hintStyle: const TextStyle(color: Colors.grey),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
  focusedErrorBorder: focusedErrorOutlineInputBorder,
);

InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  fillColor: MyTheme.surfaceColor,
  filled: true,
  hintStyle: TextStyle(color: AppColors.whiteColor.withAlpha(130)),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
  focusedErrorBorder: focusedErrorOutlineInputBorder,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.r)),
  borderSide: const BorderSide(
    width: 1,
    color: AppColors.onSurfaceColor,
  ),
);

OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.r)),
  borderSide: const BorderSide(
    width: 1,
    color: AppColors.primaryColor,
  ),
);

OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.r)),
  borderSide: const BorderSide(
    width: 1,
    color: AppColors.darkErrorColor,
  ),
);

OutlineInputBorder focusedErrorOutlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(10.r)),
  borderSide: const BorderSide(
    width: 2,
    color: AppColors.darkErrorColor,
  ),
);

import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';

import '../../core/resources/app_colors.dart';
import '../../core/resources/app_values.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.lightGreyColor,
  filled: true,
  hintStyle: const TextStyle(color: AppColors.greyColor),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  fillColor: AppColors.darkGreyColor,
  filled: true,
  hintStyle: const TextStyle(color: AppColors.whiteColor40),
  border: outlineInputBorder,
  enabledBorder: outlineInputBorder,
  focusedBorder: focusedOutlineInputBorder,
  errorBorder: errorOutlineInputBorder,
);

OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(AppBorderRadius.semiBigBorderRadius.r)),
  borderSide: const BorderSide(
    color: Colors.transparent,
  ),
);

OutlineInputBorder focusedOutlineInputBorder = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(AppBorderRadius.semiBigBorderRadius.r)),
  borderSide: const BorderSide(color: MyTheme.primaryColor),
);

OutlineInputBorder errorOutlineInputBorder = OutlineInputBorder(
  borderRadius:
      BorderRadius.all(Radius.circular(AppBorderRadius.semiBigBorderRadius.r)),
  borderSide: const BorderSide(
    color: AppColors.errorColor,
  ),
);

OutlineInputBorder secondaryOutlineInputBorder(BuildContext context) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.all(
        Radius.circular(AppBorderRadius.semiBigBorderRadius.r)),
    borderSide: BorderSide(
      color: Theme.of(context).textTheme.bodyLarge!.color!.withOpacity(0.15),
    ),
  );
}

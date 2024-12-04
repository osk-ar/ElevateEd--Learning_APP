import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UIHelpers {
  static InputDecoration style(String text, {Icon? icon}) {
    return InputDecoration(
      suffixIcon: icon,
      labelText: text,
      labelStyle: TextStyle(color: MyTheme.hintTextColor),
      contentPadding: EdgeInsets.all(AppPadding.defaultPadding.r),
    );
  }
}

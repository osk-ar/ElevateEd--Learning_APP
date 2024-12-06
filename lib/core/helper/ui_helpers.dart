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

  static Future<void> getDateInput(
      BuildContext context, TextEditingController controller) async {
    DateTime? _pickedTime = await showDatePicker(
        context: context, firstDate: DateTime(1900), lastDate: DateTime(2100));
    if (_pickedTime != null) {
      controller.text = _pickedTime.toIso8601String().split(" ")[0];
    }
  }
}

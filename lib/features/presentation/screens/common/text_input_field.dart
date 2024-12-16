import 'package:e_learning_app_gp/config/themes/input_decoration_theme.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final bool isObsecure;
  final bool isReadOnly;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  const InputField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.isObsecure,
    this.suffixIcon,
    this.isReadOnly = false,
    this.onTap,
    this.keyboardType,
    this.focusNode,
    this.nextFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.s335.w,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: isObsecure,
        validator: validator,
        keyboardType: keyboardType,
        style: AppTextStyles.lightTextStyle(context),
        decoration: InputDecoration(
          labelText: title,
          labelStyle: TextStyle(color: MyTheme.hintTextColor),
          contentPadding: EdgeInsets.all(AppPadding.defaultPadding.r),
          border: outlineInputBorder,
          suffixIcon: suffixIcon,
          focusedBorder: focusedOutlineInputBorder,
        ),
        cursorColor: MyTheme.primaryColor,
        readOnly: isReadOnly,
        onTap: onTap,
        onFieldSubmitted: nextFocusNode == null
            ? null
            : (value) => FocusScope.of(context).requestFocus(nextFocusNode),
      ),
    );
  }
}

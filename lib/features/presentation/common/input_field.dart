import 'package:ElevatED/config/themes/input_decoration_theme.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/core/resources/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final bool? isObsecure;
  final bool? isReadOnly;
  final String? hint;
  final int? minLines;
  final int? maxLines;
  const InputField({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    this.isObsecure,
    this.suffixIcon,
    this.isReadOnly = false,
    this.onTap,
    this.keyboardType,
    this.focusNode,
    this.nextFocusNode,
    this.hint,
    this.minLines,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: TextFormField(
        focusNode: focusNode,
        controller: controller,
        obscureText: isObsecure ?? false,
        validator: validator,
        keyboardType: keyboardType,
        style: getRegularStyle(
          fontSize: 14.sp,
          color: ThemeColors.textColor,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(AppEvenSizes.medium.r),
          border: outlineInputBorder,
          suffixIcon: suffixIcon,
          iconColor: ThemeColors.textColor,
          fillColor: ThemeColors.secondaryColor,
          focusedBorder: focusedOutlineInputBorder,
          hintText: title == "" ? null : title,
          hintStyle: getRegularStyle(
            fontSize: 12.sp,
            color: ThemeColors.textColor,
          ),
        ),
        minLines: minLines,
        maxLines: maxLines ?? 1,
        readOnly: isReadOnly ?? false,
        onTap: onTap,
        onFieldSubmitted: nextFocusNode == null
            ? null
            : (value) => FocusScope.of(context).requestFocus(nextFocusNode),
      ),
    );
  }
}

import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class OtpField extends StatelessWidget {
  const OtpField({super.key, this.onCompleted, this.validator});
  final void Function(String)? onCompleted;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 5,
      showCursor: true,
      validator: validator,
      onCompleted: onCompleted,
      closeKeyboardWhenCompleted: true,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      keyboardType: TextInputType.text,
      pinputAutovalidateMode: PinputAutovalidateMode.disabled,
      hapticFeedbackType: HapticFeedbackType.heavyImpact,
      errorTextStyle:
          getRegularStyle(fontSize: 14.sp, color: AppColors.lightErrorColor),
    );
  }
}

final defaultPinTheme = PinTheme(
  width: 54.w,
  height: 54.h,
  textStyle: getSemiBoldStyle(fontSize: 20.sp, color: AppColors.whiteColor),
  decoration: BoxDecoration(
    color: ThemeColors.lightSurfaceToDarkSecondary,
    borderRadius: BorderRadius.circular(10.r),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  borderRadius: BorderRadius.circular(25.r),
);

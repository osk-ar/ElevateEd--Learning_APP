import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: const ButtonStyle(
        splashFactory: NoSplash.splashFactory,
        overlayColor: WidgetStatePropertyAll(Colors.transparent),
      ),
      onPressed: () {
        print("Forget Password Clicked!");
        context.pushNamed(RouteConstants.forgetPasswordValidationScreenRoute);
      },
      child: Text(
        AppStrings.forgetPassword,
        style: getRegularStyle(color: AppColors.primaryColor, fontSize: 12.sp),
      ),
    );
  }
}

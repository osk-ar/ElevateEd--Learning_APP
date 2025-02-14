import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
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
      },
      child: Text(
        "forget password?",
        style: getRegularStyle(color: AppColors.primaryColor, fontSize: 12.sp),
      ),
    );
  }
}


/*
    GestureDetector(
      onTap: () {
        DataIntent.pushEmail(context.read<LoginCubit>().emailController.text);
        context.pushNamed(Routes.onBoardingScreenRoute);
      },
      child: Text(
        "forgot password?",
        style: AppTextStyles.lightTextStyle(context),
      ),
    );
 */
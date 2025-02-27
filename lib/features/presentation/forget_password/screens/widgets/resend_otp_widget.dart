import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/verification_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResendOTPWidget extends StatelessWidget {
  const ResendOTPWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 53.w),
        Text(
          "Didn't recieve the code?",
          style: getRegularStyle(fontSize: 14.sp, color: ThemeColors.textColor),
        ),
        SizedBox(width: 10.w),
        BlocBuilder<VerificationCubit, VerificationState>(
          builder: (context, state) {
            if (state is VerificationResentOTP) {
              return Text(
                "Resend - ${state.timer}",
                style: getRegularStyle(
                    fontSize: 14.sp, color: ThemeColors.disabledColor),
              );
            }
            return InkWell(
              splashFactory: NoSplash.splashFactory,
              overlayColor: const WidgetStatePropertyAll(Colors.transparent),
              onTap: () {
                context.read<VerificationCubit>().getOTP();
              },
              child: Text(
                "Resend",
                style: getRegularStyle(
                    fontSize: 14.sp, color: AppColors.primaryColor),
              ),
            );
          },
        ),
      ],
    );
  }
}

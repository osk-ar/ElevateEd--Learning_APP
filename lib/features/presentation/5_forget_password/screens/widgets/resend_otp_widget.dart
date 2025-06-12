import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/verification_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
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
          "didn_t_recieve_the_code_".tr(),
          style: getRegularStyle(fontSize: 14.sp, color: ThemeColors.textColor),
        ),
        SizedBox(width: 10.w),
        BlocBuilder<VerificationCubit, VerificationState>(
          builder: (context, state) {
            if (state is VerificationResentOTP) {
              return Text(
                "${"resend".tr()} - ${state.timer}",
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
                "resend".tr(),
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

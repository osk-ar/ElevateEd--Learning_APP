import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/verification_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/screens/widgets/otp_field.dart';
import 'package:ElevatED/features/presentation/forget_password/screens/widgets/resend_otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  late final GlobalKey<FormState> _otpFormKey;
  @override
  void initState() {
    _otpFormKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("Verification"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.h,
            width: double.infinity,
          ),
          DoubleCircularAvatar(
            child: Icon(
              Icons.lock_rounded,
              color: ThemeColors.inverseTextColor,
              size: 48.r,
            ),
          ),
          SizedBox(height: 36.h),
          Text(
            "Verification code sent to:",
            style:
                getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
          ),
          //todo change to dynamic email
          Text(
            "example@gmail.com",
            style:
                getRegularStyle(fontSize: 14.sp, color: ThemeColors.textColor),
          ),
          SizedBox(height: 70.h),
          Form(
            key: _otpFormKey,
            child: OtpField(
              onCompleted: (otp) {},
              validator: (otp) {
                final cubit = context.read<VerificationCubit>();
                String? verificationResult = cubit.verifyOTP(otp ?? "");
                return verificationResult;
              },
            ),
          ),
          const Spacer(),
          CTAButton(
            text: "Verify OTP",
            onPressed: () {
              print("Verify OTP CTA Clicked!");
              if (_otpFormKey.currentState?.validate() ?? false) {
                context.message(
                  message: "Verification Success!",
                  textColor: AppColors.inversePrimaryColor,
                );
                //todo navigate to change password screen
              }
            },
          ),
          SizedBox(height: 10.h),
          const ResendOTPWidget(),
          SizedBox(height: 140.h),
        ],
      ),
    );
  }
}




/*



              final cubit = context.read<VerificationCubit>();
              int remainingCount = cubit.remainingTryCount;
              if (remainingCount < 1) {
                return;
              }
              bool isValid = cubit.verifyOTP(otp);
              if (isValid) {
                //TODO Go TO change password Screen
              }


              
              final cubit = context.read<VerificationCubit>();
              int remainingCount = cubit.remainingTryCount;
              if (remainingCount < 1) {
                return "Max attempts reached, Resend otp and try again.";
              }
              bool isValid = cubit.verifyOTP(otp ?? "");
              if (isValid) {
                return null;
              }
              remainingCount = cubit.decrimentRemainingTryCount(isValid);
              return "Incorrect, Remaining Attempts: $remainingCount";


 */
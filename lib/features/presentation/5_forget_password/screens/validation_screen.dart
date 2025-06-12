import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/validation_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/state/validation_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    emailController = TextEditingController();
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("validation".tr()),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.h,
            width: double.infinity,
          ),
          DoubleCircularAvatar(
            child: Icon(
              Icons.person_rounded,
              color: ThemeColors.inverseTextColor,
              size: 48.r,
            ),
          ),
          SizedBox(height: 36.h),
          Text(
            "enter_your_email_address_".tr(),
            style:
                getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
          ),
          SizedBox(height: 100.h),
          Form(
            key: _formKey,
            child: InputField(
              title: "email".tr(),
              controller: emailController,
              validator: (value) {
                return ValidationManager.validateEmail(value);
              },
            ),
          ),
          const Spacer(),
          BlocListener<ValidationCubit, ValidationState>(
            listener: (context, state) {
              if (state is ValidationSent) {
                if (!state.didSend) return;
                MemoryCache.pushEmail(emailController.text);
                context.pushNamed(
                    RouteConstants.forgetPasswordVerificationScreenRoute);
              } else if (state is ValidationError) {
                context.message(
                    message: state.error, textColor: AppColors.lightErrorColor);
              }
            },
            child: CTAButton(
              text: "send_otp".tr(),
              onPressed: () {
                print("Send OTP Clicked!");
                if (_formKey.currentState?.validate() ?? false) {
                  context.read<ValidationCubit>().sendOtp(emailController.text);
                }
              },
            ),
          ),
          SizedBox(height: 232.h),
        ],
      ),
    );
  }
}

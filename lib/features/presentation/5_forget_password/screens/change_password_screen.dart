import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/5_forget_password/cubit/change_password_cubit.dart';
import 'package:ElevatED/features/presentation/5_forget_password/screens/widgets/custom_success_bottomsheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late final GlobalKey<FormState> _formKey;

  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmationController;

  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();

    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("change_password".tr()),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60.h,
              width: double.infinity,
            ),
            DoubleCircularAvatar(
              child: Icon(
                Icons.password_rounded,
                color: ThemeColors.inverseTextColor,
                size: 48.r,
              ),
            ),
            SizedBox(height: 36.h),
            Text(
              "enter_your_new_password_".tr(),
              style:
                  getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            SizedBox(height: 64.h),
            InputField(
              title: "password".tr(),
              controller: passwordController,
              focusNode: passwordFocusNode,
              nextFocusNode: confirmPasswordFocusNode,
              validator: (password) {
                return ValidationManager.validatePassword(password);
              },
            ),
            SizedBox(height: 16.h),
            InputField(
              title: "confirm_password".tr(),
              controller: passwordConfirmationController,
              focusNode: confirmPasswordFocusNode,
              validator: (confirmPassword) {
                return ValidationManager.validateConfirmPassword(
                  password: passwordController.text,
                  confirmPassword: confirmPassword,
                );
              },
            ),
            const Spacer(),
            BlocListener<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordSuccess) {
                  context.pushNamedAndRemoveUntil(
                      RouteConstants.loginScreenRoute,
                      predicate: (route) => false);
                }
                if (state is ChangePasswordError) {
                  context.message(message: state.error);
                }
              },
              child: CTAButton(
                text: "change_password".tr(),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    context
                        .read<ChangePasswordCubit>()
                        .changePassword(passwordController.text);
                  }
                },
              ),
            ),
            SizedBox(height: 80.h),
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                        color: AppColors.inversePrimaryColor),
                  );
                }
                return SizedBox(height: 33.h);
              },
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

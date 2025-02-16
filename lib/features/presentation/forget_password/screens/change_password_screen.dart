import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/helper/validation.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/common/input_field.dart';
import 'package:ElevatED/features/presentation/forget_password/cubit/change_password_cubit.dart';
import 'package:ElevatED/features/presentation/forget_password/screens/widgets/custom_success_bottomsheet.dart';
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
      appBar: defaultAppbar("Change Password"),
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
              "Enter your new password:",
              style:
                  getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
            ),
            SizedBox(height: 64.h),
            InputField(
              title: "Password",
              controller: passwordController,
              focusNode: passwordFocusNode,
              nextFocusNode: confirmPasswordFocusNode,
              validator: (password) {
                return Validation.validatePassword(password);
              },
            ),
            SizedBox(height: 16.h),
            InputField(
              title: "Confirm Password",
              controller: passwordConfirmationController,
              focusNode: confirmPasswordFocusNode,
              validator: (confirmPassword) {
                return Validation.validateConfirmPassword(
                  password: passwordController.text,
                  confirmPassword: confirmPassword,
                );
              },
            ),
            const Spacer(),
            BlocListener<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state is ChangePasswordLoaded) {
                  context.bottomSheet(child: const BottomSuccessSheet());
                }
              },
              child: CTAButton(
                text: "Change Password",
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
// when back is pressed call a void function then await 2 seconds if its pressed again before the timer exit the app
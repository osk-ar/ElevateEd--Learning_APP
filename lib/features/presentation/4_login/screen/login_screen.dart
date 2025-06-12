import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/0_common/rotating_logo.dart';
import 'package:ElevatED/features/presentation/4_login/cubits/login_cubit.dart';
import 'package:ElevatED/features/presentation/4_login/screen/widgets/forget_password.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/0_common/remember_me_box.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/4_login/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final GlobalKey<FormState> loginFormStateKey;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode submitButtonFocusNode;
  @override
  void initState() {
    loginFormStateKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    submitButtonFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    submitButtonFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar(AppStrings.login),
      body: Form(
        key: loginFormStateKey,
        child: Column(
          children: [
            SizedBox(height: 60.h),
            DoubleCircularAvatar(
              child: SizedBox(
                width: 46.r,
                height: 46.r,
                child: const RotatingLogo(isInfiniteRotation: true),
              ),
            ),
            SizedBox(height: 60.h),
            InputField(
              focusNode: emailFocusNode,
              controller: emailController,
              nextFocusNode: passwordFocusNode,
              title: AppStrings.email,
              isObsecure: false,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => ValidationManager.validateEmail(value),
            ),
            SizedBox(height: 24.h),
            BlocBuilder<LoginCubit, LoginState>(
              builder: (context, state) {
                return InputField(
                  title: AppStrings.password,
                  focusNode: passwordFocusNode,
                  controller: passwordController,
                  nextFocusNode: submitButtonFocusNode,
                  isObsecure: !context.read<LoginCubit>().isPasswordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      context.read<LoginCubit>().isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ThemeColors.textColor,
                    ),
                    onPressed: () =>
                        context.read<LoginCubit>().togglePasswordVisibility(),
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(right: 35.w, left: 30.w),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RememberMeBox(),
                  ForgetPassword(),
                ],
              ),
            ),
            const Spacer(),
            BlocListener<LoginCubit, LoginState>(
              listener: (context, state) {
                if (state is LoginSuccess) {
                  context.message(message: AppStrings.success);
                  context.pushReplacementNamed(RouteConstants.mainScreenRoute);
                } else if (state is LoginFailure) {
                  context.message(
                      message: "${AppStrings.error}: ${state.error}");
                }
              },
              child: CTAButton(
                focusNode: submitButtonFocusNode,
                text: AppStrings.login,
                onPressed: () async {
                  if (loginFormStateKey.currentState!.validate() &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    await context.read<LoginCubit>().login(
                        email: emailController.text,
                        password: passwordController.text);
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.dontHaveAnAccount,
                  style: getRegularStyle(
                    fontSize: 14.sp,
                    color: ThemeColors.textColor,
                  ),
                ),
                TextButton(
                  style: const ButtonStyle(
                    splashFactory: NoSplash.splashFactory,
                    overlayColor: WidgetStatePropertyAll(Colors.transparent),
                  ),
                  onPressed: () {
                    context
                        .pushReplacementNamed(RouteConstants.signupScreenRoute);
                  },
                  child: Text(
                    AppStrings.register,
                    style: getSemiBoldStyle(
                      fontSize: 14.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

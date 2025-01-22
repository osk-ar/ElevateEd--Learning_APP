import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/validation.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/login/cubits/login_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_form_layout.dart';
import 'package:e_learning_app_gp/features/presentation/login/screen/widgets/forget_password.dart';
import 'package:e_learning_app_gp/features/presentation/common/header.dart';
import 'package:e_learning_app_gp/features/presentation/common/text_input_field.dart';
import 'package:e_learning_app_gp/features/presentation/common/checkable.dart';
import 'package:e_learning_app_gp/features/presentation/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/common/or_line.dart';
import 'package:e_learning_app_gp/features/presentation/common/social.dart';
import 'package:e_learning_app_gp/features/presentation/login/states/login_state.dart';
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
    return DefaultFormLayout(
      topPadding: AppSize.s60,
      leftPadding: AppSize.s24,
      rightPadding: AppSize.s24,
      bottomPadding: AppSize.s0,
      scrollable: false,
      formKey: loginFormStateKey,
      child: Column(
        children: [
          const Header(
            title: "Welcome Back!",
            subTitle: "You have been missed",
          ),
          SizedBox(height: AppSize.s60.h),
          InputField(
            focusNode: emailFocusNode,
            nextFocusNode: passwordFocusNode,
            title: "Email",
            controller: emailController,
            validator: (value) => Validation.validateEmail(value),
            keyboardType: TextInputType.emailAddress,
            isObsecure: false,
          ),
          SizedBox(height: AppSize.s32.h),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return InputField(
                focusNode: passwordFocusNode,
                nextFocusNode: submitButtonFocusNode,
                title: "Password",
                controller: passwordController,
                isObsecure: !context.read<LoginCubit>().isPasswordVisible,
                validator: (value) => Validation.validatePassword(value),
                suffixIcon: IconButton(
                  icon: Icon(
                    context.read<LoginCubit>().isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: MyTheme.textColor,
                  ),
                  onPressed: () =>
                      context.read<LoginCubit>().togglePasswordVisibility(),
                ),
              );
            },
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Checkable(),
              ForgetPassword(),
            ],
          ),
          SizedBox(height: AppSize.s24.h),
          const OrLine(),
          SizedBox(height: AppSize.s24.h),
          Social(
              onTapFacebook: () => print("Facebook Tapped"),
              onTapGoogle: () => print("Google Tapped")),
          const Spacer(),
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                context.message(message: "success");
                DataIntent.pushAuthResponseData(state.user);
                context.pushReplacementNamed(Routes.courseDetailsScreenRoute);
              } else if (state is LoginFailure) {
                context.message(message: "error${state.error}");
              }
            },
            child: CustomButton(
              focusNode: submitButtonFocusNode,
              color: MyTheme.primaryColor,
              colorText: Colors.white,
              text: "Login",
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
          SizedBox(height: AppSize.s0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?",
                  style: AppTextStyles.semiBoldHintTextStyle(context)),
              TextButton(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  context.pushReplacementNamed(Routes.signupScreenRoute);
                },
                child: Text(
                  "Sign up",
                  style: AppTextStyles.textButtonTextStyle(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

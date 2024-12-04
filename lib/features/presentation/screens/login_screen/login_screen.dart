import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/dependency_injection.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/validation.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/data_sources/local/app_prefs.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/login_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/screens/login_screen/widgets/forget_password.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/auth_header.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/text_input_field.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/checkable.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/default_layout.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/or_line.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/social.dart';
import 'package:e_learning_app_gp/features/presentation/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      topPadding: AppSize.s60,
      leftPadding: AppSize.s24,
      rightPadding: AppSize.s24,
      bottomPadding: AppSize.s0,
      children: [
        const Header(),
        SizedBox(height: AppSize.s60.h),
        InputField(
          title: "Email",
          controller: context.read<LoginCubit>().emailController,
          validator: (value) => Validation.validateEmail(value),
          isObsecure: false,
        ),
        SizedBox(height: AppSize.s32.h),
        InputField(
          title: "Password",
          controller: context.read<LoginCubit>().passwordController,
          isObsecure: !context.read<LoginCubit>().isPasswordVisible,
          validator: (value) => Validation.validatePassword(value),
          suffixIcon: IconButton(
            icon: Icon(
              context.read<LoginCubit>().isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.black45,
            ),
            onPressed: () =>
                context.read<LoginCubit>().togglePasswordVisibility(),
          ),
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
          onTapFacebook: () async {
            bool? ok = await context.read<LoginCubit>().authWithFacebook();
            print(ok);
          },
          onTapGoogle: () async =>
              await context.read<LoginCubit>().authWithGoogle(),
        ),
        const Spacer(),
        BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              context.message(message: "success");
              sl<AppPrefs>().setBool(KeyPrefs.IS_LOGGEDIN.name, true);
              sl<AppPrefs>()
                  .setString(KeyPrefs.TOKEN.name, DataIntent.getToken()!);
              sl<AppPrefs>()
                  .setString(KeyPrefs.ID.name, DataIntent.getUserID()!);
              context.pushReplacementNamed(Routes.onBoardingScreenRoute);
            } else if (state is LoginFailure) {
              context.message(message: "error${state.error}");
            }
          },
          child: CustomButton(
            color: MyTheme.primaryColor,
            colorText: MyTheme.inverseTextColor,
            text: "Login",
            onPressed: () async {
              if (context.read<LoginCubit>().emailController.text.isNotEmpty &&
                  context
                      .read<LoginCubit>()
                      .passwordController
                      .text
                      .isNotEmpty) {
                await context.read<LoginCubit>().login();
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
              onPressed: () {},
              child: Text(
                "Sign up",
                style: AppTextStyles.textButtonTextStyle(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

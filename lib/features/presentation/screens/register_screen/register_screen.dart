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
import 'package:e_learning_app_gp/features/presentation/cubits/register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/auth_header.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/text_input_field.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/default_layout.dart';
import 'package:e_learning_app_gp/features/presentation/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      topPadding: AppSize.s48,
      leftPadding: AppSize.s24,
      rightPadding: AppSize.s24,
      bottomPadding: AppSize.s0,
      scrollable: true,
      child: Column(
        children: [
          const Header(
            isLogin: false,
          ),
          SizedBox(height: AppSize.s60.h),
          InputField(
            title: "Name",
            isObsecure: false,
            validator: (value) => Validation.validateName(value),
            controller: context.read<RegisterCubit>().fullNameController,
          ),
          SizedBox(height: AppSize.s32.h),
          InputField(
            title: "Email",
            controller: context.read<RegisterCubit>().emailController,
            validator: (value) => Validation.validateEmail(value),
            isObsecure: false,
          ),
          SizedBox(height: AppSize.s32.h),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return InputField(
                title: "Password",
                controller: context.read<RegisterCubit>().passwordController,
                isObsecure: !context.read<RegisterCubit>().isPasswordVisible,
                validator: (value) => Validation.validatePassword(value),
                suffixIcon: IconButton(
                  icon: Icon(
                    context.read<RegisterCubit>().isPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black45,
                  ),
                  onPressed: () =>
                      context.read<RegisterCubit>().togglePasswordVisibility(),
                ),
              );
            },
          ),
          SizedBox(height: AppSize.s32.h),
          BlocBuilder<RegisterCubit, RegisterState>(
            builder: (context, state) {
              return InputField(
                title: "Confirm Password",
                isObsecure:
                    !context.read<RegisterCubit>().isConfirmPasswordVisible,
                validator: (value) => Validation.validatePassword(value),
                controller:
                    context.read<RegisterCubit>().confirmPasswordController,
                suffixIcon: IconButton(
                  icon: Icon(
                    context.read<RegisterCubit>().isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.black45,
                  ),
                  onPressed: () => context
                      .read<RegisterCubit>()
                      .toggleConfirmPasswordVisibility(),
                ),
              );
            },
          ),
          SizedBox(height: AppSize.s32.h),
          InputField(
              title: "Phone Number",
              isObsecure: false,
              validator: (value) => Validation.validatePassword(value),
              controller: context.read<RegisterCubit>().phoneNumberController),
          SizedBox(height: AppSize.s32.h),
          InputField(
            title: "Date Of Birth",
            isObsecure: false,
            validator: (value) => Validation.validatePassword(value),
            controller: context.read<RegisterCubit>().birthDateController,
          ),
          SizedBox(height: AppSize.s32.h),
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                context.message(message: "success");
                sl<AppPrefs>().setBool(KeyPrefs.IS_LOGGEDIN.name, true);
                sl<AppPrefs>()
                    .setString(KeyPrefs.TOKEN.name, DataIntent.getToken()!);
                sl<AppPrefs>()
                    .setString(KeyPrefs.ID.name, DataIntent.getUserID()!);
                context.pushReplacementNamed(Routes.onBoardingScreenRoute);
              } else if (state is RegisterFailure) {
                context.message(message: "error${state.error}");
              }
            },
            child: CustomButton(
              color: MyTheme.primaryColor,
              colorText: MyTheme.inverseTextColor,
              text: "Register",
              onPressed: () async {
                if (context
                        .read<RegisterCubit>()
                        .emailController
                        .text
                        .isNotEmpty &&
                    context
                        .read<RegisterCubit>()
                        .passwordController
                        .text
                        .isNotEmpty) {
                  await context.read<RegisterCubit>().register();
                }
              },
            ),
          ),
          SizedBox(height: AppSize.s0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?",
                  style: AppTextStyles.semiBoldHintTextStyle(context)),
              TextButton(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {},
                child: Text(
                  "Sign in",
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

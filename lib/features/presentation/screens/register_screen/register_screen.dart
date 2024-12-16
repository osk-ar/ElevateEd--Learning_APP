import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/validation.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/cubits/register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/auth_header.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/text_input_field.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/screens/common/default_layout.dart';
import 'package:e_learning_app_gp/features/presentation/screens/register_screen/widgets/role_picker.dart';
import 'package:e_learning_app_gp/features/presentation/states/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> registerFormStateKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: registerFormStateKey,
      child: DefaultLayout(
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
            SizedBox(height: AppSize.s30.h),
            const RolePicker(),
            SizedBox(height: AppSize.s24.h),
            InputField(
              title: "Email",
              controller: context.read<RegisterCubit>().emailController,
              validator: (value) => Validation.validateEmail(value),
              focusNode: context.read<RegisterCubit>().emailFocusNode,
              nextFocusNode: context.read<RegisterCubit>().passwordFocusNode,
              isObsecure: false,
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: AppSize.s32.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return InputField(
                  title: "Password",
                  controller: context.read<RegisterCubit>().passwordController,
                  validator: (value) => Validation.validatePassword(value),
                  focusNode: context.read<RegisterCubit>().passwordFocusNode,
                  nextFocusNode:
                      context.read<RegisterCubit>().confirmPasswordFocusNode,
                  isObsecure: !context.read<RegisterCubit>().isPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      context.read<RegisterCubit>().isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: MyTheme.textColor,
                    ),
                    onPressed: () => context
                        .read<RegisterCubit>()
                        .togglePasswordVisibility(),
                  ),
                );
              },
            ),
            SizedBox(height: AppSize.s32.h),
            BlocBuilder<RegisterCubit, RegisterState>(
              builder: (context, state) {
                return InputField(
                  title: "Confirm Password",
                  controller:
                      context.read<RegisterCubit>().confirmPasswordController,
                  validator: (value) => Validation.validatePassword(value),
                  focusNode:
                      context.read<RegisterCubit>().confirmPasswordFocusNode,
                  nextFocusNode:
                      context.read<RegisterCubit>().fullNameFocusNode,
                  isObsecure:
                      !context.read<RegisterCubit>().isConfirmPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      context.read<RegisterCubit>().isConfirmPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: MyTheme.textColor,
                    ),
                    onPressed: () => context
                        .read<RegisterCubit>()
                        .toggleConfirmPasswordVisibility(),
                  ),
                );
              },
            ),
            SizedBox(height: AppSize.s16.h),
            Divider(
              indent: 15,
              endIndent: 15,
              color: MyTheme.textColor.withOpacity(0.7),
              thickness: 2,
            ),
            SizedBox(height: AppSize.s16.h),
            InputField(
              title: "Name",
              controller: context.read<RegisterCubit>().fullNameController,
              validator: (value) => Validation.validateName(value),
              focusNode: context.read<RegisterCubit>().fullNameFocusNode,
              nextFocusNode: context.read<RegisterCubit>().phoneNumberFocusNode,
              isObsecure: false,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: AppSize.s32.h),
            InputField(
              title: "Phone Number",
              controller: context.read<RegisterCubit>().phoneNumberController,
              validator: (value) => Validation.validatePhoneNumber(value),
              focusNode: context.read<RegisterCubit>().phoneNumberFocusNode,
              isObsecure: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: AppSize.s32.h),
            InputField(
              title: "Date Of Birth",
              controller: context.read<RegisterCubit>().birthDateController,
              validator: (value) => Validation.validateBirthDate(value),
              isObsecure: false,
              isReadOnly: true,
              suffixIcon: const Icon(
                Icons.date_range_rounded,
                color: MyTheme.textColor,
              ),
              onTap: () async {
                await context.read<RegisterCubit>().getDateInput(context);
              },
            ),
            SizedBox(height: AppSize.s32.h),
            BlocListener<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterSuccess) {
                  context.message(message: "success");

                  context.pushReplacementNamed(Routes.onBoardingScreenRoute);
                } else if (state is RegisterFailure) {
                  context.message(message: "error${state.error}");
                }
              },
              child: CustomButton(
                color: MyTheme.primaryColor,
                colorText: Colors.white,
                text: "Continue",
                onPressed: () async {
                  if (!registerFormStateKey.currentState!.validate()) {
                    return;
                  }
                  if (context.read<RegisterCubit>().passwordController.text !=
                      context
                          .read<RegisterCubit>()
                          .confirmPasswordController
                          .text) {
                    context.message(
                        message: "Password & ConfirmPassword Doesn't Match");
                    return;
                  }
                  context.read<RegisterCubit>().pushInfoToDataIntent(context);
                  context.read<RegisterCubit>().navigateToNextScreen(context);
                },
              ),
            ),
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
                  onPressed: () {
                    context.pushNamed(Routes.loginScreenRoute);
                  },
                  child: Text(
                    "Sign in",
                    style: AppTextStyles.textButtonTextStyle(context),
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

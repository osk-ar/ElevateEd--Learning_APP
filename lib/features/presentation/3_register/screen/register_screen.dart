import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/register_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/states/register_state.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/3_register/screen/widgets/date_picker.dart';
import 'package:ElevatED/features/presentation/3_register/screen/widgets/role_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //- FormKey
  late final GlobalKey<FormState> registerFormStateKey;
  //- role selector
  UserRoleEnum userRole = UserRoleEnum.student;

  //- controllers
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController fullNameController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController birthDateController;

  //- focus Nodes
  late final FocusNode emailFocusNode;
  late final FocusNode passwordFocusNode;
  late final FocusNode confirmPasswordFocusNode;
  late final FocusNode fullNameFocusNode;
  late final FocusNode phoneNumberFocusNode;

  @override
  void initState() {
    //- FormKey Initial
    registerFormStateKey = GlobalKey<FormState>();
    // controllers Initial
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    fullNameController = TextEditingController();
    phoneNumberController = TextEditingController();
    birthDateController = TextEditingController();
    // focusNodes Initial
    emailFocusNode = FocusNode();
    passwordFocusNode = FocusNode();
    confirmPasswordFocusNode = FocusNode();
    fullNameFocusNode = FocusNode();
    phoneNumberFocusNode = FocusNode();
    // super Initial
    super.initState();
  }

  @override
  void dispose() {
    // controllers Dispose
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    birthDateController.dispose();
    // focusNodes Dispose
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();
    fullNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    // super Dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar(AppStrings.register),
      body: SingleChildScrollView(
        child: Form(
          key: registerFormStateKey,
          child: Column(
            children: [
              SizedBox(height: 30.h),
              BlocSelector<RegisterCubit, RegisterState, UserRoleEnum>(
                selector: (state) => state.userRole,
                builder: (context, selectedUserRole) {
                  userRole = selectedUserRole;
                  return RolePicker(
                    isStudent:
                        selectedUserRole == UserRoleEnum.student ? true : false,
                  );
                },
              ),
              SizedBox(height: 24.h),
              InputField(
                title: AppStrings.email,
                controller: emailController,
                validator: (value) => ValidationManager.validateEmail(value),
                focusNode: emailFocusNode,
                nextFocusNode: passwordFocusNode,
                isObsecure: false,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 24.h),
              BlocSelector<RegisterCubit, RegisterState, bool>(
                selector: (state) => state.isPasswordVisible,
                builder: (context, isPasswordVisible) {
                  return InputField(
                    title: AppStrings.password,
                    controller: passwordController,
                    validator: (value) =>
                        ValidationManager.validatePassword(value),
                    focusNode: passwordFocusNode,
                    nextFocusNode: confirmPasswordFocusNode,
                    isObsecure: !isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: ThemeColors.textColor,
                      ),
                      onPressed: () => context
                          .read<RegisterCubit>()
                          .togglePasswordVisibility(),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),
              BlocSelector<RegisterCubit, RegisterState, bool>(
                selector: (state) => state.isConfirmPasswordVisible,
                builder: (context, confirmPasswordVisible) {
                  return InputField(
                    title: AppStrings.confirmPassword,
                    controller: confirmPasswordController,
                    validator: (value) =>
                        ValidationManager.validateConfirmPassword(
                            confirmPassword: value,
                            password: passwordController.text),
                    focusNode: confirmPasswordFocusNode,
                    nextFocusNode: fullNameFocusNode,
                    isObsecure: !confirmPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: ThemeColors.textColor,
                      ),
                      onPressed: () => context
                          .read<RegisterCubit>()
                          .toggleConfirmPasswordVisibility(),
                    ),
                  );
                },
              ),
              SizedBox(height: 24.h),
              Divider(
                indent: 30.w,
                endIndent: 30.w,
                color: ThemeColors.textColor.withAlpha(155),
                thickness: 2,
              ),
              SizedBox(height: 24.h),
              InputField(
                title: AppStrings.name,
                controller: fullNameController,
                validator: (value) => ValidationManager.validateName(value),
                focusNode: fullNameFocusNode,
                nextFocusNode: phoneNumberFocusNode,
                isObsecure: false,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 24.h),
              InputField(
                title: AppStrings.phoneNumber,
                controller: phoneNumberController,
                validator: (value) =>
                    ValidationManager.validatePhoneNumber(value),
                focusNode: phoneNumberFocusNode,
                isObsecure: false,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: 24.h),
              InputField(
                title: AppStrings.dateOfBirth,
                controller: birthDateController,
                validator: (value) =>
                    ValidationManager.validateBirthDate(value),
                isObsecure: false,
                isReadOnly: true,
                suffixIcon: const Icon(
                  Icons.date_range_rounded,
                  color: ThemeColors.textColor,
                ),
                onTap: () async {
                  String? date = await getDateInput(context);
                  birthDateController.text = date ?? "";
                },
              ),
              SizedBox(height: 48.h),
              CTAButton(
                text: AppStrings.continueString,
                onPressed: () async {
                  //validte inputs
                  if (!registerFormStateKey.currentState!.validate()) {
                    return;
                  }

                  // push data to next screen
                  MemoryCache.pushRegisterData({
                    "role": userRole,
                    "email": emailController.text,
                    "password": passwordController.text,
                    "fullName": fullNameController.text,
                    "phone": phoneNumberController.text,
                    "birthDate": birthDateController.text,
                  });

                  // navigate to next screen
                  context.read<RegisterCubit>().navigateToNextScreen(context);
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppStrings.alreadyHaveAnAccount,
                      style: getMediumStyle(
                          fontSize: 16.sp, color: ThemeColors.textColor)),
                  TextButton(
                    style: const ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      overlayColor: WidgetStatePropertyAll(Colors.transparent),
                    ),
                    onPressed: () {
                      context.pushReplacementNamed(
                          RouteConstants.loginScreenRoute);
                    },
                    child: Text(
                      AppStrings.signIn,
                      style: getMediumStyle(
                          fontSize: 16.sp, color: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 36.h),
            ],
          ),
        ),
      ),
    );
  }
}

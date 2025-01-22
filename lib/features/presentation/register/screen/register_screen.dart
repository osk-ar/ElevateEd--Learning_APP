import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/constants/enum.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/validation.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/register_state.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_form_layout.dart';
import 'package:e_learning_app_gp/features/presentation/common/header.dart';
import 'package:e_learning_app_gp/features/presentation/common/text_input_field.dart';
import 'package:e_learning_app_gp/features/presentation/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/widgets/date_picker.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/widgets/role_picker.dart';
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
    return DefaultFormLayout(
      topPadding: AppSize.s48,
      leftPadding: AppSize.s24,
      rightPadding: AppSize.s24,
      bottomPadding: AppSize.s0,
      scrollable: true,
      formKey: registerFormStateKey,
      child: Column(
        children: [
          const Header(
            title: "Hello There!",
            subTitle: "Create a new account",
          ),
          SizedBox(height: AppSize.s30.h),
          BlocSelector<RegisterCubit, RegisterState, UserRole>(
            selector: (state) => state.userRole,
            builder: (context, selectedUserRole) {
              return RolePicker(
                isStudent: selectedUserRole == UserRole.STUDENT ? true : false,
              );
            },
          ),
          SizedBox(height: AppSize.s24.h),
          InputField(
            title: "Email",
            controller: emailController,
            validator: (value) => Validation.validateEmail(value),
            focusNode: emailFocusNode,
            nextFocusNode: passwordFocusNode,
            isObsecure: false,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppSize.s32.h),
          BlocSelector<RegisterCubit, RegisterState, bool>(
            selector: (state) => state.isPasswordVisible,
            builder: (context, isPasswordVisible) {
              return InputField(
                title: "Password",
                controller: passwordController,
                validator: (value) => Validation.validatePassword(value),
                focusNode: passwordFocusNode,
                nextFocusNode: confirmPasswordFocusNode,
                isObsecure: !isPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    color: MyTheme.textColor,
                  ),
                  onPressed: () =>
                      context.read<RegisterCubit>().togglePasswordVisibility(),
                ),
              );
            },
          ),
          SizedBox(height: AppSize.s32.h),
          BlocSelector<RegisterCubit, RegisterState, bool>(
            selector: (state) => state.isConfirmPasswordVisible,
            builder: (context, confirmPasswordVisible) {
              return InputField(
                title: "Confirm Password",
                controller: confirmPasswordController,
                validator: (value) => Validation.validateConfirmPassword(
                    confirmPassword: value, password: passwordController.text),
                focusNode: confirmPasswordFocusNode,
                nextFocusNode: fullNameFocusNode,
                isObsecure: !confirmPasswordVisible,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    confirmPasswordVisible
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
            controller: fullNameController,
            validator: (value) => Validation.validateName(value),
            focusNode: fullNameFocusNode,
            nextFocusNode: phoneNumberFocusNode,
            isObsecure: false,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: AppSize.s32.h),
          InputField(
            title: "Phone Number",
            controller: phoneNumberController,
            validator: (value) => Validation.validatePhoneNumber(value),
            focusNode: phoneNumberFocusNode,
            isObsecure: false,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: AppSize.s32.h),
          InputField(
            title: "Date Of Birth",
            controller: birthDateController,
            validator: (value) => Validation.validateBirthDate(value),
            isObsecure: false,
            isReadOnly: true,
            suffixIcon: const Icon(
              Icons.date_range_rounded,
              color: MyTheme.textColor,
            ),
            onTap: () async {
              String? date = await getDateInput(context);
              birthDateController.text = date ?? "";
            },
          ),
          SizedBox(height: AppSize.s32.h),
          CustomButton(
            color: MyTheme.primaryColor,
            colorText: Colors.white,
            text: "Continue",
            onPressed: () async {
              //validte inputs
              if (!registerFormStateKey.currentState!.validate()) {
                return;
              }

              // push data to next screen
              DataIntent.pushRegisterData({
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
              Text("Already have an account?",
                  style: AppTextStyles.semiBoldHintTextStyle(context)),
              TextButton(
                style: const ButtonStyle(
                  splashFactory: NoSplash.splashFactory,
                  overlayColor: WidgetStatePropertyAll(Colors.transparent),
                ),
                onPressed: () {
                  context.pushReplacementNamed(Routes.loginScreenRoute);
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
    );
  }
}

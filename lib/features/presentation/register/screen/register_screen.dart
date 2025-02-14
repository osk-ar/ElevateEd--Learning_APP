import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/core/helper/data_intent.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/helper/validation.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/register/cubits/register_cubit.dart';
import 'package:ElevatED/features/presentation/register/states/register_state.dart';
import 'package:ElevatED/features/presentation/common/text_input_field.dart';
import 'package:ElevatED/features/presentation/common/custom_button.dart';
import 'package:ElevatED/features/presentation/register/screen/widgets/date_picker.dart';
import 'package:ElevatED/features/presentation/register/screen/widgets/role_picker.dart';
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

  //- role selector

  UserRole userRole = UserRole.student;

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
      appBar: defaultAppbar("Register"),
      body: Form(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            BlocSelector<RegisterCubit, RegisterState, UserRole>(
              selector: (state) => state.userRole,
              builder: (context, selectedUserRole) {
                userRole = selectedUserRole;
                return RolePicker(
                  isStudent:
                      selectedUserRole == UserRole.student ? true : false,
                );
              },
            ),
            SizedBox(height: 24.h),
            InputField(
              title: "Email",
              controller: emailController,
              validator: (value) => Validation.validateEmail(value),
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
                  title: "Password",
                  controller: passwordController,
                  validator: (value) => Validation.validatePassword(value),
                  focusNode: passwordFocusNode,
                  nextFocusNode: confirmPasswordFocusNode,
                  isObsecure: !isPasswordVisible,
                  keyboardType: TextInputType.visiblePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
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
            SizedBox(height: 24.h),
            BlocSelector<RegisterCubit, RegisterState, bool>(
              selector: (state) => state.isConfirmPasswordVisible,
              builder: (context, confirmPasswordVisible) {
                return InputField(
                  title: "Confirm Password",
                  controller: confirmPasswordController,
                  validator: (value) => Validation.validateConfirmPassword(
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
                      color: MyTheme.textColor,
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
              color: MyTheme.textColor.withOpacity(0.7),
              thickness: 2,
            ),
            SizedBox(height: 24.h),
            InputField(
              title: "Name",
              controller: fullNameController,
              validator: (value) => Validation.validateName(value),
              focusNode: fullNameFocusNode,
              nextFocusNode: phoneNumberFocusNode,
              isObsecure: false,
              keyboardType: TextInputType.name,
            ),
            SizedBox(height: 24.h),
            InputField(
              title: "Phone Number",
              controller: phoneNumberController,
              validator: (value) => Validation.validatePhoneNumber(value),
              focusNode: phoneNumberFocusNode,
              isObsecure: false,
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 24.h),
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
            const Spacer(),
            CTAButton(
              text: "Continue",
              onPressed: () async {
                //validte inputs
                if (!registerFormStateKey.currentState!.validate()) {
                  return;
                }

                // push data to next screen
                DataIntent.pushRegisterData({
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
                Text("Already have an account?",
                    style: getMediumStyle(
                        fontSize: 16.sp, color: ThemeColors.textColor)),
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
                    style: getMediumStyle(
                        fontSize: 16.sp, color: AppColors.primaryColor),
                  ),
                ),
              ],
            ),
            SizedBox(height: 44.h),
          ],
        ),
      ),
    );
  }
}

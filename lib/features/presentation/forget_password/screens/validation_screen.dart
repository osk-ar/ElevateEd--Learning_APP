import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/common/double_circular_avatar.dart';
import 'package:ElevatED/features/presentation/common/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ValidationScreen extends StatefulWidget {
  const ValidationScreen({super.key});

  @override
  State<ValidationScreen> createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationScreen> {
  late final TextEditingController emailController;

  @override
  void initState() {
    emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("Validation"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60.h,
            width: double.infinity,
          ),
          DoubleCircularAvatar(
            child: Icon(
              Icons.person_rounded,
              color: ThemeColors.inverseTextColor,
              size: 48.r,
            ),
          ),
          SizedBox(height: 36.h),
          Text(
            "Enter your email address:",
            style:
                getMediumStyle(fontSize: 16.sp, color: ThemeColors.textColor),
          ),
          SizedBox(height: 100.h),
          InputField(title: "Email", controller: emailController),
          const Spacer(),
          CTAButton(
            text: "Send OTP",
            onPressed: () {
              //TODO add action to send otp
              print("OTP Clicked!");
            },
          ),
          SizedBox(height: 232.h),
        ],
      ),
    );
  }
}

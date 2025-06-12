import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/image_picker_wdiget.dart';

class StudentEditProfileScreen extends StatefulWidget {
  const StudentEditProfileScreen({super.key});

  @override
  State<StudentEditProfileScreen> createState() =>
      _StudentEditProfileScreenState();
}

class _StudentEditProfileScreenState extends State<StudentEditProfileScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("edit_profile".tr()),
      body: Column(
        spacing: 24.h,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 0),
          const ImagePickerWidget(
            imageExist: false,
          ),
          const SizedBox(),
          InputField(title: "email".tr(), controller: _emailController),
          InputField(title: "phone".tr(), controller: _phoneController),
          InputField(
            title: "description".tr(),
            controller: _descriptionController,
            maxLines: 5,
          ),
          const Spacer(),
          CTAButton(text: "save".tr(), onPressed: () {}),
          const SizedBox(
            width: double.infinity,
            height: 0,
          ),
        ],
      ),
    );
  }
}

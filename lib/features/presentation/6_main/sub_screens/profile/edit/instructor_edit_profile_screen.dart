import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/3_register/screen/widgets/suggestions_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;

  @override
  void initState() {
    _titleController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
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
          InputField(
              title: "professional_title".tr(), controller: _titleController),
          InputField(title: "email".tr(), controller: _titleController),
          InputField(title: "phone".tr(), controller: _titleController),
          SuggestionsWidget(
              suggestions: MemoryCache.getCategories(),
              editSuggestions: (interset) {},
              suggestionSelected: (interset) => false),
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

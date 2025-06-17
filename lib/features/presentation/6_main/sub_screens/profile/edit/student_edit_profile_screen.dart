import 'package:ElevatED/features/presentation/6_main/cubits/categories_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/image_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/save_profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/3_register/screen/widgets/suggestions_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';

class StudentEditProfileScreen extends StatefulWidget {
  const StudentEditProfileScreen({super.key});

  @override
  State<StudentEditProfileScreen> createState() =>
      _StudentEditProfileScreenState();
}

class _StudentEditProfileScreenState extends State<StudentEditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  late final TextEditingController _phoneController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _descriptionController = TextEditingController();

    context.read<CategoriesCubit>().getCategories();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _onSave() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final imageCubit = context.read<ImageCubit>();
    if (!imageCubit.hasImage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('profile_image_is_required'.tr())),
      );
      return;
    }

    final categoriesCubit = context.read<CategoriesCubit>();
    if (categoriesCubit.selectedCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('please_choose_one_interest'.tr())),
      );
      return;
    }

    final saveCubit = context.read<SaveProfileCubit>();
    saveCubit.saveProfile(
      profileImage: imageCubit.profileImage!,
      selectedCategories: categoriesCubit.selectedCategories,
      email: _emailController.text,
      phone: _phoneController.text,
      description: _descriptionController.text,
      title: "student",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("edit_profile".tr()),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 24.h,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 0),
              BlocBuilder<ImageCubit, ImageState>(
                buildWhen: (previous, current) =>
                    current is ImageUpdated || current is ImageCleared,
                builder: (context, state) {
                  return ImagePickerWidget(
                    imageExist: state is ImageUpdated,
                    imageFile: state is ImageUpdated ? state.imageFile : null,
                    onTap: () {
                      final cubit = context.read<ImageCubit>();
                      if (state is ImageUpdated) {
                        cubit.clearImage();
                      } else {
                        cubit.selectImage(context);
                      }
                    },
                  );
                },
              ),
              const SizedBox(),
              InputField(
                title: "email".tr(),
                controller: _emailController,
                validator: ValidationManager.validateEmail,
              ),
              InputField(
                title: "phone".tr(),
                controller: _phoneController,
                validator: ValidationManager.validatePhoneNumber,
              ),
              InputField(
                title: "description".tr(),
                controller: _descriptionController,
                maxLines: 5,
                validator: ValidationManager.validateCourseDescription,
              ),
              BlocBuilder<CategoriesCubit, CategoriesState>(
                buildWhen: (previous, current) =>
                    current is CategoriesLoaded || current is CategoriesLoading,
                builder: (context, state) {
                  if (state is CategoriesLoaded) {
                    return SuggestionsWidget(
                      suggestions: state.categories,
                      editSuggestions: (category) {
                        context
                            .read<CategoriesCubit>()
                            .toggleCategory(category);
                      },
                      suggestionSelected: (category) =>
                          state.selectedCategories.contains(category),
                    );
                  }
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox.shrink();
                },
              ),
              SizedBox(height: 24.h),
              BlocConsumer<SaveProfileCubit, SaveProfileState>(
                listener: (context, state) {
                  if (state is SaveProfileError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  return CTAButton(
                    text: "save".tr(),
                    onPressed: state is SaveProfileSaving ? null : _onSave,
                    isLoading: state is SaveProfileSaving,
                  );
                },
              ),
              const SizedBox(
                width: double.infinity,
                height: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

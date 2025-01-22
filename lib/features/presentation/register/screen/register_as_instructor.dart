import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/input_decoration_theme.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/helper/validation.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/instructor_register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/instructor_register_state.dart';
import 'package:e_learning_app_gp/features/presentation/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_form_layout.dart';
import 'package:e_learning_app_gp/features/presentation/common/header.dart';
import 'package:e_learning_app_gp/features/presentation/common/image_picker_wdiget.dart';
import 'package:e_learning_app_gp/features/presentation/common/text_input_field.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/widgets/suggestions_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterAsInstructor extends StatelessWidget {
  const RegisterAsInstructor({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultFormLayout(
      bottomPadding: 0,
      scrollable: true,
      formKey: context
          .read<InstructorRegisterCubit>()
          .instructorRegisterFormStateKey,
      child: Column(
        children: [
          SizedBox(height: 30.h),
          const Header(
            title: "Instructor Register",
            subTitle: "We need more information to sign you up",
          ),
          SizedBox(height: 30.h),
          BlocBuilder<InstructorRegisterCubit, InstructorRegisterState>(
            builder: (context, state) {
              return ImagePicker(
                iconSize: 40.r,
                radius: 77.r,
                borderWidth: 3.r,
                imageExist:
                    context.read<InstructorRegisterCubit>().profileImage !=
                        null,
                imageFile: context.read<InstructorRegisterCubit>().profileImage,
                onTap: () {
                  if (context.read<InstructorRegisterCubit>().profileImage ==
                      null) {
                    print("Choose An image");
                    context
                        .read<InstructorRegisterCubit>()
                        .selectImage(context);
                  } else {
                    print("Image Cleared");
                    context.read<InstructorRegisterCubit>().clearImage();
                  }
                },
              );
            },
          ),
          SizedBox(height: 20.h),
          InputField(
            title: "Professional Title",
            controller: TextEditingController(),
            validator: (value) => Validation.validateTitle(value),
            isObsecure: false,
            keyboardType: TextInputType.name,
            focusNode: context.read<InstructorRegisterCubit>().titleFocusNode,
            nextFocusNode: context.read<InstructorRegisterCubit>().bioFocusNode,
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: AppSize.s335.w,
            child: TextFormField(
              controller: context.read<InstructorRegisterCubit>().bioController,
              keyboardType: TextInputType.text,
              style: AppTextStyles.lightTextStyle(context),
              minLines: 1,
              maxLines: 5,
              focusNode: context.read<InstructorRegisterCubit>().bioFocusNode,
              decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: AppTextStyles.regularTextStyle(
                  context,
                  color: MyTheme.labelTextColor,
                ),
                contentPadding: EdgeInsets.all(AppPadding.defaultPadding.r),
                border: outlineInputBorder,
                focusedBorder: focusedOutlineInputBorder,
              ),
            ),
          ),
          SizedBox(height: 40.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Choose One or More Field of Expertise:",
              style: AppTextStyles.mediumTextStyle(context,
                  fontSize: 14, color: MyTheme.textColor),
            ),
          ),
          SizedBox(height: 10.h),
          SuggestionsWidget(
            editSuggestions: (topic) =>
                context.read<InstructorRegisterCubit>().editSuggestions(topic),
            suggestionSelected: (topic) => context
                .read<InstructorRegisterCubit>()
                .suggestionSelected(topic),
            getSelectedSuggestionTextColor: (topic) => context
                .read<InstructorRegisterCubit>()
                .getSelectedSuggestionTextColor(topic),
          ),
          SizedBox(height: 30.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Optional, add social media links:",
              style: AppTextStyles.mediumTextStyle(context,
                  fontSize: 14, color: MyTheme.textColor),
            ),
          ),
          SizedBox(height: 20.h),
          InputField(
            title: "Facebook",
            controller: TextEditingController(),
            validator: (value) => Validation.linkValidator(value, 1),
            isObsecure: false,
            keyboardType: TextInputType.name,
            hint: "https://www.facebook.com/username",
          ),
          SizedBox(height: 20.h),
          InputField(
            title: "LinkedIn",
            controller: TextEditingController(),
            validator: (value) => Validation.linkValidator(value, 2),
            isObsecure: false,
            keyboardType: TextInputType.name,
            hint: "https://www.linkedin.com/in/username",
          ),
          SizedBox(height: 20.h),
          InputField(
            title: "GitHub",
            controller: TextEditingController(),
            validator: (value) => Validation.linkValidator(value, 3),
            isObsecure: false,
            keyboardType: TextInputType.name,
            hint: "https://github.com/username",
          ),
          SizedBox(height: 20.h),
          InputField(
            title: "Portfolio",
            controller: TextEditingController(),
            validator: (value) => Validation.linkValidator(value, 4),
            isObsecure: false,
            keyboardType: TextInputType.name,
            hint: "https://www.example.com/path",
          ),
          SizedBox(height: 40.h),
          BlocListener<InstructorRegisterCubit, InstructorRegisterState>(
            listener: (context, state) {
              if (state is InstructorRegisterSuccess) {
                context.message(message: "success");

                context.pushReplacementNamed(Routes.statisticsScreenRoute);
              } else if (state is InstructorRegisterFailure) {
                context.message(message: "error${state.error}");
              }
            },
            child: CustomButton(
              text: "Register",
              onPressed: () {
                print("Loading Instructor Register...");
                if (!context
                    .read<InstructorRegisterCubit>()
                    .instructorRegisterFormStateKey
                    .currentState!
                    .validate()) {
                  return;
                }

                if (context
                    .read<InstructorRegisterCubit>()
                    .expertiseFields
                    .isEmpty) {
                  context.message(
                      message: "Please choose at least 1 Expertise",
                      textColor: Colors.red[300],
                      duration: const Duration(seconds: 3));
                  return;
                }
                context
                    .read<InstructorRegisterCubit>()
                    .addLinksToPersonalList();
                context.read<InstructorRegisterCubit>().register();
              },
              color: MyTheme.primaryColor,
              colorText: Colors.white,
            ),
          ),
          SizedBox(height: 42.h)
        ],
      ),
    );
  }
}

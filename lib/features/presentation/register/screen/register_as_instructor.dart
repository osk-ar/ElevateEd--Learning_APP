import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/input_decoration_theme.dart';
import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/helper/validation.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/core/resources/app_sizes.dart';
import 'package:ElevatED/features/presentation/register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/register/states/instructor_register_state.dart';
import 'package:ElevatED/features/presentation/common/custom_button.dart';
import 'package:ElevatED/features/presentation/common/layouts/default_form_layout.dart';
import 'package:ElevatED/features/presentation/common/header.dart';
import 'package:ElevatED/features/presentation/common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/common/text_input_field.dart';
import 'package:ElevatED/features/presentation/register/screen/widgets/suggestions_picker.dart';
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
            width: 335.w,
            child: TextFormField(
              controller: context.read<InstructorRegisterCubit>().bioController,
              keyboardType: TextInputType.text,
              style: getLightStyle(color: MyTheme.textColor, fontSize: 16.sp),
              minLines: 1,
              maxLines: 5,
              focusNode: context.read<InstructorRegisterCubit>().bioFocusNode,
              decoration: InputDecoration(
                labelText: "Bio",
                labelStyle: getRegularStyle(
                  fontSize: 16.sp,
                  color: MyTheme.labelTextColor,
                ),
                contentPadding: EdgeInsets.all(AppEvenSizes.medium.r),
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
              style: getMediumStyle(fontSize: 14.sp, color: MyTheme.textColor),
            ),
          ),
          SizedBox(height: 10.h),
          SuggestionsWidget(
            editSuggestions: (topic) =>
                context.read<InstructorRegisterCubit>().editSuggestions(topic),
            suggestionSelected: (topic) => context
                .read<InstructorRegisterCubit>()
                .suggestionSelected(topic),
          ),
          SizedBox(height: 30.h),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              "Optional, add social media links:",
              style: getMediumStyle(fontSize: 14.sp, color: MyTheme.textColor),
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
            child: CTAButton(
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
            ),
          ),
          SizedBox(height: 42.h)
        ],
      ),
    );
  }
}

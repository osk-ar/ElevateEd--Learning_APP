import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme.dart';
import 'package:ElevatED/core/helper/memory_cache.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/common/input_field.dart';
import 'package:ElevatED/features/presentation/register/cubits/student_register_cubit.dart';
import 'package:ElevatED/features/presentation/register/states/student_register_state.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:ElevatED/features/presentation/common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/register/screen/widgets/suggestions_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterAsStudent extends StatefulWidget {
  const RegisterAsStudent({super.key});

  @override
  State<RegisterAsStudent> createState() => _RegisterAsStudentState();
}

class _RegisterAsStudentState extends State<RegisterAsStudent> {
  late final TextEditingController bioController;
  @override
  void initState() {
    bioController = TextEditingController()..text = "Hi, I'm new to ElevatED";
    super.initState();
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<StudentRegisterCubit>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ThemeColors.backgroundColor,
      appBar: defaultAppbar("Student Register"),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          BlocBuilder<StudentRegisterCubit, StudentRegisterState>(
            builder: (context, state) {
              return ImagePicker(
                iconSize: 24.r,
                radius: 61.r,
                borderWidth: 6.r,
                imageExist:
                    context.read<StudentRegisterCubit>().profileImage != null,
                imageFile: context.read<StudentRegisterCubit>().profileImage,
                onTap: () {
                  if (context.read<StudentRegisterCubit>().profileImage ==
                      null) {
                    print("Choosing An image");
                    context.read<StudentRegisterCubit>().selectImage(context);
                  } else {
                    context.read<StudentRegisterCubit>().clearImage();
                    print("Image Cleared");
                  }
                },
              );
            },
          ),
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Bio:",
                style: getMediumStyle(
                    fontSize: 14.sp, color: ThemeColors.textColor),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          InputField(
            controller: bioController,
            keyboardType: TextInputType.text,
            title: "",
            minLines: 1,
            maxLines: 5,
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Choose One or More Interests:",
                style: getMediumStyle(
                    fontSize: 14.sp, color: ThemeColors.textColor),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          SuggestionsWidget(
            editSuggestions: (topic) => cubit.editSuggestions(topic),
            suggestionSelected: (topic) => cubit.suggestionSelected(topic),
          ),
          const Spacer(),
          BlocListener<StudentRegisterCubit, StudentRegisterState>(
            listener: (context, state) {
              if (state is StudentRegisterSuccess) {
                // give message with success
                context.message(message: "success");
                // push dataIntent
                MemoryCache.pushAuthResponseData(state.responseModel);
                // navigate to next screen
                context.pushReplacementNamed(Routes.mainScreenRoute);
              } else if (state is StudentRegisterFailure) {
                // give message with error
                context.message(message: "error${state.error}");
              }
            },
            child: CTAButton(
              text: "Register",
              onPressed: () {
                if (context.read<StudentRegisterCubit>().interests.isEmpty) {
                  context.message(
                      message: "Please choose at least 1 Interest",
                      textColor: AppColors.lightErrorColor,
                      duration: const Duration(seconds: 3));
                  return;
                }
                print("Loading Student Register...");
                context
                    .read<StudentRegisterCubit>()
                    .register(bio: bioController.text);
              },
            ),
          ),
          SizedBox(
            height: 64.h,
          ),
        ],
      ),
    );
  }
}

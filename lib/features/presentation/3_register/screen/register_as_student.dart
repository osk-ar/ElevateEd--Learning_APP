import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/student_register_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/states/student_register_state.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/3_register/screen/widgets/suggestions_picker.dart';
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
    bioController = TextEditingController()..text = AppStrings.defaultBio;
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
      appBar: defaultAppbar(AppStrings.studentRegister),
      body: Column(
        children: [
          SizedBox(height: 30.h),
          BlocBuilder<StudentRegisterCubit, StudentRegisterState>(
            builder: (context, state) {
              final cubit = context.read<StudentRegisterCubit>();
              return ImagePickerWidget(
                iconSize: 24.r,
                radius: 61.r,
                borderWidth: 6.r,
                imageExist: cubit.profileImage != null,
                imageFile: cubit.profileImage,
                onTap: () {
                  switch (cubit.profileImage) {
                    case null:
                      cubit.selectImage(context);
                      break;
                    default:
                      cubit.clearImage();
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
                AppStrings.bio,
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
                AppStrings.chooseOneOrMoreInterests,
                style: getMediumStyle(
                    fontSize: 14.sp, color: ThemeColors.textColor),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          BlocBuilder<StudentRegisterCubit, StudentRegisterState>(
            builder: (context, state) {
              final cubit = context.read<StudentRegisterCubit>();
              if (cubit.isCategoriesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (cubit.categoriesError != null) {
                return Text(cubit.categoriesError!,
                    style: const TextStyle(color: Colors.red));
              } else if (cubit.categories.isNotEmpty) {
                return SuggestionsWidget(
                  suggestions: cubit.categories,
                  editSuggestions: (cat) => cubit.editSuggestions(cat),
                  suggestionSelected: (cat) => cubit.suggestionSelected(cat),
                );
              } else {
                return const Text("No categories available");
              }
            },
          ),
          const Spacer(),
          BlocListener<StudentRegisterCubit, StudentRegisterState>(
            listener: (context, state) {
              print(state);
              switch (state) {
                case StudentRegisterSuccess():
                  {
                    // give message with success
                    context.message(message: AppStrings.success);
                    // navigate to next screen
                    context
                        .pushReplacementNamed(RouteConstants.mainScreenRoute);
                    break;
                  }

                case StudentRegisterFailure():
                  {
                    context.message(
                        message: "${AppStrings.error}: ${state.error}");
                    break;
                  }
              }
            },
            child: CTAButton(
              text: AppStrings.register,
              onPressed: () {
                if (context.read<StudentRegisterCubit>().interests.isEmpty) {
                  context.message(
                      message: AppStrings.pleaseChooseOneInterest,
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

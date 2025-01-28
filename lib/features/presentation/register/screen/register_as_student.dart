import 'package:e_learning_app_gp/config/routes/route_constants.dart';
import 'package:e_learning_app_gp/config/themes/input_decoration_theme.dart';
import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/helper/data_intent.dart';
import 'package:e_learning_app_gp/core/helper/extensions.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:e_learning_app_gp/features/presentation/register/cubits/student_register_cubit.dart';
import 'package:e_learning_app_gp/features/presentation/register/states/student_register_state.dart';
import 'package:e_learning_app_gp/features/presentation/common/custom_button.dart';
import 'package:e_learning_app_gp/features/presentation/common/header.dart';
import 'package:e_learning_app_gp/features/presentation/common/layouts/default_layout.dart';
import 'package:e_learning_app_gp/features/presentation/common/image_picker_wdiget.dart';
import 'package:e_learning_app_gp/features/presentation/register/screen/widgets/suggestions_picker.dart';
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
    // TODO: implement initState
    bioController = TextEditingController()
      ..text = "Hi, I'm new here! No welcome?";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.backgroundColor,
      body: DefaultLayout(
        scrollable: true,
        child: Column(
          children: [
            SizedBox(height: 30.h),
            const Header(
              title: "Student Register",
              subTitle: "One more step to start learning",
            ),
            SizedBox(height: 30.h),
            BlocBuilder<StudentRegisterCubit, StudentRegisterState>(
              builder: (context, state) {
                return ImagePicker(
                  iconSize: 40.r,
                  radius: 77.r,
                  borderWidth: 3.r,
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
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Add a short description about yourself:",
                style: AppTextStyles.mediumTextStyle(context,
                    fontSize: 14, color: MyTheme.textColor),
              ),
            ),
            SizedBox(height: 20.h),
            TextFormField(
              controller: bioController,
              keyboardType: TextInputType.text,
              style: AppTextStyles.lightTextStyle(context),
              minLines: 1,
              maxLines: 5,
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
            SizedBox(height: 40.h),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "Choose One or More Interests:",
                style: AppTextStyles.mediumTextStyle(context,
                    fontSize: 14, color: MyTheme.textColor),
              ),
            ),
            SizedBox(height: 10.h),
            SuggestionsWidget(
              editSuggestions: (topic) =>
                  context.read<StudentRegisterCubit>().editSuggestions(topic),
              suggestionSelected: (topic) => context
                  .read<StudentRegisterCubit>()
                  .suggestionSelected(topic),
              getSelectedSuggestionTextColor: (topic) => context
                  .read<StudentRegisterCubit>()
                  .getSelectedSuggestionTextColor(topic),
            ),
            SizedBox(height: 30.h),
            BlocListener<StudentRegisterCubit, StudentRegisterState>(
              listener: (context, state) {
                if (state is StudentRegisterSuccess) {
                  // give message with success
                  context.message(message: "success");
                  // push dataIntent
                  DataIntent.pushAuthResponseData(state.responseModel);
                  // navigate to next screen
                  context.pushReplacementNamed(Routes.statisticsScreenRoute);
                } else if (state is StudentRegisterFailure) {
                  // give message with error
                  context.message(message: "error${state.error}");
                }
              },
              child: CustomButton(
                text: "Register",
                color: MyTheme.primaryColor,
                colorText: Colors.white,
                onPressed: () {
                  if (context.read<StudentRegisterCubit>().interests.isEmpty) {
                    context.message(
                        message: "Please choose at least 1 Interest",
                        textColor: Colors.red[300],
                        duration: const Duration(seconds: 3));
                    return;
                  }
                  print("Loading Student Register...");
                  context
                      .read<StudentRegisterCubit>()
                      .register(bio: bioController.text);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

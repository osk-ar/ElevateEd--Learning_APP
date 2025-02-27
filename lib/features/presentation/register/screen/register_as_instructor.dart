import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/helper/extensions.dart';
import 'package:ElevatED/core/helper/validation.dart';
import 'package:ElevatED/core/resources/app_styles.dart';
import 'package:ElevatED/features/presentation/common/default_appbar.dart';
import 'package:ElevatED/features/presentation/register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/register/states/instructor_register_state.dart';
import 'package:ElevatED/features/presentation/common/cta_button.dart';
import 'package:ElevatED/features/presentation/common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/common/input_field.dart';
import 'package:ElevatED/features/presentation/register/screen/widgets/suggestions_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterAsInstructor extends StatefulWidget {
  const RegisterAsInstructor({super.key});

  @override
  State<RegisterAsInstructor> createState() => _RegisterAsInstructorState();
}

class _RegisterAsInstructorState extends State<RegisterAsInstructor> {
  late final GlobalKey<FormState> instructorRegisterFormStateKey;

  late final FocusNode titleFocusNode;
  late final FocusNode bioFocusNode;
  late final FocusNode facebookFocusNode;
  late final FocusNode githubFocusNode;
  late final FocusNode linkedInFocusNode;
  late final FocusNode portfolioFocusNode;

  late final TextEditingController titleController;
  late final TextEditingController bioController;
  late final TextEditingController facebookController;
  late final TextEditingController githubController;
  late final TextEditingController linkedInController;
  late final TextEditingController portfolioController;

  @override
  void initState() {
    instructorRegisterFormStateKey = GlobalKey<FormState>();

    titleFocusNode = FocusNode();
    bioFocusNode = FocusNode();
    facebookFocusNode = FocusNode();
    githubFocusNode = FocusNode();
    linkedInFocusNode = FocusNode();
    portfolioFocusNode = FocusNode();

    titleController = TextEditingController();
    bioController = TextEditingController()..text = "Hello I'm new to ElevatED";
    facebookController = TextEditingController();
    githubController = TextEditingController();
    linkedInController = TextEditingController();
    portfolioController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    // controllers Dispose
    titleController.dispose();
    bioController.dispose();
    facebookController.dispose();
    githubController.dispose();
    linkedInController.dispose();
    portfolioController.dispose();

    // focusNodes Dispose
    titleFocusNode.dispose();
    bioFocusNode.dispose();
    facebookFocusNode.dispose();
    githubFocusNode.dispose();
    linkedInFocusNode.dispose();
    portfolioFocusNode.dispose();

    // super Dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> instructorRegisterFormStateKey =
        GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: instructorRegisterFormStateKey,
          child: Column(
            children: [
              defaultAppbar("Instructor Register"),
              SizedBox(height: 30.h),
              BlocBuilder<InstructorRegisterCubit, InstructorRegisterState>(
                builder: (context, state) {
                  final cubit = context.read<InstructorRegisterCubit>();
                  return ImagePicker(
                    iconSize: 24.r,
                    radius: 61.r,
                    borderWidth: 6.r,
                    imageExist: cubit.profileImage != null,
                    imageFile: cubit.profileImage,
                    onTap: () {
                      if (cubit.profileImage == null) {
                        print("Choose An image");
                        cubit.selectImage(context);
                      } else {
                        print("Image Cleared");
                        cubit.clearImage();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 40.h),
              InputField(
                title: "Professional Title",
                controller: TextEditingController(),
                validator: (value) => Validation.validateTitle(value),
                isObsecure: false,
                keyboardType: TextInputType.name,
                focusNode: titleFocusNode,
                nextFocusNode: bioFocusNode,
              ),
              SizedBox(height: 20.h),
              InputField(
                controller: bioController,
                keyboardType: TextInputType.text,
                title: "",
                minLines: 1,
                maxLines: 5,
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Choose your experties:",
                    style: getMediumStyle(
                        fontSize: 16.sp, color: ThemeColors.textColor),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SuggestionsWidget(
                editSuggestions: (topic) => context
                    .read<InstructorRegisterCubit>()
                    .editSuggestions(topic),
                suggestionSelected: (topic) => context
                    .read<InstructorRegisterCubit>()
                    .suggestionSelected(topic),
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    "Optional, add social links:",
                    style: getMediumStyle(
                        fontSize: 14.sp, color: MyTheme.textColor),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
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
                    final cubit = context.read<InstructorRegisterCubit>();
                    print("Loading Instructor Register...");
                    if (!instructorRegisterFormStateKey.currentState!
                        .validate()) {
                      return;
                    }

                    if (cubit.expertiseFields.isEmpty) {
                      context.message(
                          message: "Please choose at least 1 Expertise",
                          textColor: Colors.red[300],
                          duration: const Duration(seconds: 3));
                      return;
                    }
                    cubit.addLinksToPersonalList(
                        facebookController.text,
                        githubController.text,
                        linkedInController.text,
                        portfolioController.text);
                    cubit.register(titleController.text, bioController.text);
                  },
                ),
              ),
              SizedBox(height: 64.h)
            ],
          ),
        ),
      ),
    );
  }
}

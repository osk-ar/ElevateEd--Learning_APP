import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/3_register/cubits/instructor_register_cubit.dart';
import 'package:ElevatED/features/presentation/3_register/states/instructor_register_state.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/image_picker_wdiget.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/3_register/screen/widgets/suggestions_picker.dart';
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
    bioController = TextEditingController()..text = AppStrings.defaultBio;
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
              defaultAppbar(AppStrings.instructorRegister),
              SizedBox(height: 30.h),
              BlocBuilder<InstructorRegisterCubit, InstructorRegisterState>(
                builder: (context, state) {
                  final cubit = context.read<InstructorRegisterCubit>();
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
                      });
                },
              ),
              SizedBox(height: 40.h),
              InputField(
                title: AppStrings.professionalTitle,
                controller: TextEditingController(),
                validator: (value) => ValidationManager.validateTitle(value),
                isObsecure: false,
                keyboardType: TextInputType.name,
                focusNode: titleFocusNode,
                nextFocusNode: bioFocusNode,
              ),
              SizedBox(height: 20.h),
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
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.chooseYourExperties,
                    style: getMediumStyle(
                        fontSize: 16.sp, color: ThemeColors.textColor),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              BlocBuilder<InstructorRegisterCubit, InstructorRegisterState>(
                builder: (context, state) {
                  final cubit = context.read<InstructorRegisterCubit>();
                  if (cubit.isCategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (cubit.categoriesError != null) {
                    return Text(cubit.categoriesError!,
                        style: const TextStyle(color: Colors.red));
                  } else if (cubit.categories.isNotEmpty) {
                    return SuggestionsWidget(
                      suggestions: cubit.categories,
                      editSuggestions: (cat) => cubit.editExpertise(cat),
                      suggestionSelected: (cat) =>
                          cubit.suggestionSelected(cat),
                    );
                  } else {
                    return const Text("No categories available");
                  }
                },
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    AppStrings.optionalAddSocialLinks,
                    style: getMediumStyle(
                        fontSize: 14.sp, color: ThemeColors.textColor),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              InputField(
                title: AppStrings.facebook,
                controller: TextEditingController(),
                validator: (value) => ValidationManager.linkValidator(value, 1),
                isObsecure: false,
                keyboardType: TextInputType.name,
                hint: "https://www.facebook.com/username",
              ),
              SizedBox(height: 20.h),
              InputField(
                title: AppStrings.linkedIn,
                controller: TextEditingController(),
                validator: (value) => ValidationManager.linkValidator(value, 2),
                isObsecure: false,
                keyboardType: TextInputType.name,
                hint: "https://www.linkedin.com/in/username",
              ),
              SizedBox(height: 20.h),
              InputField(
                title: AppStrings.gitHub,
                controller: TextEditingController(),
                validator: (value) => ValidationManager.linkValidator(value, 3),
                isObsecure: false,
                keyboardType: TextInputType.name,
                hint: "https://github.com/username",
              ),
              SizedBox(height: 20.h),
              InputField(
                title: AppStrings.portfolio,
                controller: TextEditingController(),
                validator: (value) => ValidationManager.linkValidator(value, 4),
                isObsecure: false,
                keyboardType: TextInputType.name,
                hint: "https://www.example.com/path",
              ),
              SizedBox(height: 40.h),
              BlocListener<InstructorRegisterCubit, InstructorRegisterState>(
                listener: (context, state) {
                  print(state);
                  switch (state) {
                    case InstructorRegisterSuccess():
                      {
                        // give message with success
                        context.message(message: AppStrings.success);
                        // navigate to next screen
                        context.pushReplacementNamed(
                            RouteConstants.mainScreenRoute);
                        break;
                      }

                    case InstructorRegisterFailure():
                      {
                        context.message(
                            message: "${AppStrings.error}: ${state.error}");
                        break;
                      }

                    default:
                      {
                        context.message(
                            message:
                                "${AppStrings.error}: Unhandled state in: register as instructor");
                      }
                  }
                },
                child: CTAButton(
                  text: AppStrings.register,
                  onPressed: () {
                    final cubit = context.read<InstructorRegisterCubit>();
                    print("Loading Instructor Register...");
                    if (!instructorRegisterFormStateKey.currentState!
                        .validate()) {
                      return;
                    }

                    if (cubit.expertiseFields.isEmpty) {
                      context.message(
                          message: AppStrings.pleaseChooseAtleastOneExpertise,
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

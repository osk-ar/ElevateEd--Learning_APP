import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/managers/validation_manager.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/0_common/input_field.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/content_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddVideoForm extends StatefulWidget {
  const AddVideoForm({super.key});

  @override
  State<AddVideoForm> createState() => _AddVideoFormState();
}

class _AddVideoFormState extends State<AddVideoForm> {
  final _titleController = TextEditingController();
  UploadCourseVideo? video;

  late final GlobalKey<FormState> _formKey;
  late final ContentCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ContentCubit>();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  Future<void> _pickVideo() async {
    final pickedVideo = await cubit.pickVideo(context);
    if (pickedVideo != null && mounted) {
      setState(() {
        video = pickedVideo;
        if (_titleController.text.isEmpty) {
          _titleController.text = video!.title;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: defaultAppbar(AppStrings.addVideoForm),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16.h,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputField(
                controller: _titleController,
                title: AppStrings.videoTitle,
                validator: (value) =>
                    ValidationManager.validateVideoTitle(value),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Text(
                  "note: when picking a video if title is empty the video title will be extracted automatically.",
                  style: getRegularStyle(
                      fontSize: 14.sp,
                      color: ThemeColors.textColor.withAlpha(175)),
                ),
              ),
              const SizedBox.shrink(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: _pickVideo,
                    icon: const Icon(Icons.image),
                    label: Text(AppStrings.chooseVideo),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.lightSurfaceToDarkSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        side: BorderSide(
                          color: AppColors.primaryColor,
                          width: 1.r,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (video != null) ...[
                SizedBox(height: 16.h),
                Text(
                  'Selected video: ${video!.title}',
                  style: getMediumStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const Spacer(),
              CTAButton(
                text: AppStrings.submit,
                onPressed: () {
                  if (video == null || !_formKey.currentState!.validate()) {
                    context.message(
                        message: AppStrings.selectVideoAndThumbnail);
                    return;
                  }
                  video!.title = _titleController.text;
                  cubit.addContent(video);
                  context.pop();
                },
              ),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}

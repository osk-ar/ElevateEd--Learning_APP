import 'dart:developer';

import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/11_upload_course/screen/widgets/upload_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/presentation/11_upload_course/cubits/upload_course_cubit.dart';
import 'package:ElevatED/features/presentation/0_common/cta_button.dart';

class UploadCourseScreen extends StatefulWidget {
  const UploadCourseScreen({super.key, required this.courseModel});
  final UploadCourseModel courseModel;

  @override
  State<UploadCourseScreen> createState() => _UploadCourseScreenState();
}

class _UploadCourseScreenState extends State<UploadCourseScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UploadCourseCubit>().startUpload(widget.courseModel);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppbar("Uploading Course...", showBackButton: false),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: BlocBuilder<UploadCourseCubit, UploadCourseState>(
          builder: (context, state) {
            if (state is UploadCourseProgress) {
              log("state.steps: ${state.steps}");
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: ListView.separated(
                      itemCount: state.steps.length,
                      itemBuilder: (context, index) => UploadItemWidget(
                        properities: state.steps[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 8.h,
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is UploadCourseSuccess || state is UploadCourseError) {
              String statusText = '';
              bool isSuccess = false;
              if (state is UploadCourseSuccess) {
                statusText = 'Upload Success!';
                isSuccess = true;
              } else if (state is UploadCourseError) {
                statusText = 'Error: ${state.message}';
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    statusText,
                    style: TextStyle(
                      color: isSuccess ? Colors.green : Colors.red,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.h),
                  Center(
                    child: CTAButton(
                      text: 'Go to Home',
                      onPressed: isSuccess || !isSuccess
                          ? () {
                              context.pushNamedAndRemoveUntil(
                                '/main',
                                predicate: (route) => false,
                              );
                            }
                          : null,
                      isLoading: false,
                    ),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}


/*

1- course details
2- tasks list
3- videos list

 */
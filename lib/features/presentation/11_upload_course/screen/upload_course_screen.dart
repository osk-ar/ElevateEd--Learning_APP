import 'dart:developer';

import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/presentation/0_common/default_appbar.dart';
import 'package:ElevatED/features/presentation/11_upload_course/screen/widgets/upload_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/presentation/11_upload_course/cubits/upload_course_cubit.dart';

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
      appBar: defaultAppbar("Uploading Course..."),
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
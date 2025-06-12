import 'dart:developer';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubit/create_course_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/widgets/course_building_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentStep extends StatelessWidget {
  const ContentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateCourseCubit, CreateCourseState>(
      buildWhen: (previous, current) {
        return current is CreateCourseContentUpdated ||
            current is CreateCourseContentLoading;
      },
      builder: (context, state) {
        log("message : CreateCourseCourseContentUpdated");
        final cubit = context.read<CreateCourseCubit>();
        if (state is CreateCourseContentLoading) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        switch (cubit.courseContent.length) {
          case 0:
            return SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Center(child: Text(AppStrings.noDataInList)),
              ),
            );
          default:
            return SliverReorderableList(
              itemCount: cubit.courseContent.length,
              itemBuilder: (context, index) {
                final item = cubit.courseContent[index];
                final String type = item is UploadCourseVideo
                    ? AppStrings.video
                    : AppStrings.asign;
                final key = ValueKey(index);
                return ReorderableDragStartListener(
                  index: index,
                  key: key,
                  child: Dismissible(
                    key: key,
                    onDismissed: (direction) {
                      cubit.removeContentItem(index);
                    },
                    child: CourseBuildingBlock(
                      index: item.index + 1,
                      title: item.title,
                      type: type,
                      icon: Icons.close_rounded,
                      buttonCallBack: () {
                        cubit.removeContentItem(index);
                      },
                    ),
                  ),
                );
              },
              onReorder: (oldIndex, newIndex) {
                cubit.reOrderContent(oldIndex, newIndex);
              },
            );
        }
      },
    );
  }
}

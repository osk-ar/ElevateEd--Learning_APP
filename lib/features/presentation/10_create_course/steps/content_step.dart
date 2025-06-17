import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/content_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/states/content_states.dart';
import 'package:ElevatED/features/presentation/10_create_course/widgets/course_building_block.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContentStep extends StatelessWidget {
  const ContentStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContentCubit, ContentState>(
      listenWhen: (previous, current) => current is ContentError,
      listener: (context, state) {
        if (state is ContentError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      buildWhen: (previous, current) => current is! ContentInitial,
      builder: (context, state) {
        final cubit = context.read<ContentCubit>();

        if (state is ContentLoading) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  SizedBox(height: 16.h),
                  Text(
                    'Loading content...',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ContentError) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48.r,
                      color: Colors.red,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Error loading content',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.red,
                          ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      state.message,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        final content = cubit.content;

        if (content.isEmpty) {
          return SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      size: 48.r,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      AppStrings.noDataInList,
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Add videos or assignments to your course',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        return SliverReorderableList(
          itemCount: content.length,
          itemBuilder: (context, index) {
            final item = content[index];
            final String type =
                item is UploadCourseVideo ? AppStrings.video : AppStrings.asign;
            final key = ValueKey('${item.runtimeType}_$index');

            return ReorderableDragStartListener(
              index: index,
              key: key,
              child: Dismissible(
                key: key,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 16.r),
                  child: Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 24.r,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  cubit.removeContent(index);
                  context.message(message: "${type.capitalize()} removed");
                },
                child: CourseBuildingBlock(
                  index: item.index + 1,
                  title: item.title,
                  type: type,
                ),
              ),
            );
          },
          onReorder: (oldIndex, newIndex) {
            cubit.reorderContent(oldIndex, newIndex);
          },
        );
      },
    );
  }
}

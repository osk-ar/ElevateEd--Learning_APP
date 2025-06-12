import 'dart:developer';

import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/presentation/0_common/expandable_text.dart';
import 'package:ElevatED/features/presentation/course_details/cubits/course_details_cubit.dart';
import 'package:ElevatED/features/presentation/course_details/screen/widgets/instructor_list_tile.dart';
import 'package:ElevatED/features/presentation/course_details/screen/widgets/course_item_list_tile.dart';
import 'package:ElevatED/features/presentation/course_details/states/course_details_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseDetailsScreen extends StatefulWidget {
  final int courseId;
  const CourseDetailsScreen({super.key, required this.courseId});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CourseDetailsCubit>().loadCourse(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _getFAB,
      body: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        listener: (context, state) {
          if (state is CourseDetailsPaymentUrlReceived) {
            _launchPaymentUrl(state.paymentUrl);
          } else if (state is CourseDetailsError) {
            context.message(message: state.message);
          }
        },
        builder: (context, state) {
          if (state is CourseDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CourseDetailsError) {
            return Center(
              child: Text(
                'Error: ${state.message}',
                style: getRegularStyle(
                  fontSize: 16.sp,
                  color: ThemeColors.warningColor,
                ),
              ),
            );
          } else if (state is CourseDetailsLoaded) {
            final course = state.course;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: ThemeColors.lightSurfaceToDarkSecondary,
                  shadowColor: ThemeColors.textColor.withAlpha(76),
                  surfaceTintColor: Colors.transparent,
                  expandedHeight: MediaQuery.sizeOf(context).width * (9 / 16),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      "https://picsum.photos/200/300",
                      fit: BoxFit.cover,
                      color: Colors.black.withAlpha(76),
                      colorBlendMode: BlendMode.darken,
                    ),
                    title: Text(
                      course.title,
                      style: getMediumStyle(
                        fontSize: 16.sp,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        context.read<CourseDetailsCubit>().toggleFavorite();
                      },
                      icon: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
                        buildWhen: (previous, current) {
                          return current is CourseDetailsFavouriteChanged;
                        },
                        builder: (context, state) {
                          late bool isFavorite;
                          if (state is CourseDetailsFavouriteChanged) {
                            isFavorite = state.isFavorite;
                          } else {
                            isFavorite = false;
                          }
                          return Icon(
                            isFavorite
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: ThemeColors.textColor,
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      spacing: 16.h,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(width: double.infinity),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              AppStrings.formatCategory(course.category.name),
                              style: getSemiBoldStyle(
                                fontSize: 20.sp,
                                color: ThemeColors.textColor,
                              ),
                            ),
                            Text(
                              '${course.price} ${AppStrings.currency}',
                              style: getBoldStyle(
                                fontSize: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          AppStrings.aboutCourse,
                          style: getBoldStyle(
                            fontSize: 16.sp,
                            color: ThemeColors.textColor,
                          ),
                        ),
                        ExpandableText(text: course.description),
                        InstructorListTile(
                          instructorName: course.instructorName,
                          onPressed: () {
                            //TODO navigate to instructor profile
                            log("TODO: navigate to instructor profile");
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 40.h,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.r),
                                    ),
                                  ),
                                  onPressed: () {
                                    //TODO navigate to this course chat group
                                  },
                                  child: Text(
                                    AppStrings.community,
                                    style: getRegularStyle(
                                      fontSize: 14.sp,
                                      color: ThemeColors.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                height: 40.h,
                                child: Center(
                                  child: Text(
                                    AppStrings.formatRating(
                                        course.rating.toStringAsFixed(1)),
                                    style: getRegularStyle(
                                      fontSize: 14.sp,
                                      color: ThemeColors.textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                  sliver: SliverList.separated(
                    addRepaintBoundaries: false,
                    itemCount:
                        course.videos.length + course.assignments.length + 1,
                    itemBuilder: (context, index) {
                      if (index ==
                          course.videos.length + course.assignments.length) {
                        return SizedBox(height: 48.h);
                      }
                      if (index < course.videos.length) {
                        final video = course.videos[index];
                        return CourseItemListTile(
                          title: '${video.index + 1}. ${video.title}',
                          icon: Icons.play_arrow,
                          onTap: () {
                            if (course.isOwned) {
                              context.message(
                                  message:
                                      AppStrings.videoPlayerNotImplemented);
                            } else {
                              context.message(
                                  message:
                                      AppStrings.purchaseRequiredForVideos);
                            }
                          },
                        );
                      } else {
                        final assignment =
                            course.assignments[index - course.videos.length];
                        return ListTile(
                          leading: Icon(Icons.assignment,
                              size: 32.w, color: ThemeColors.textColor),
                          title: Text(
                            '${assignment.index + 1}. ${assignment.title}',
                            style: getMediumStyle(
                              fontSize: 16.sp,
                              color: ThemeColors.textColor,
                            ),
                          ),
                          onTap: () {
                            if (course.isOwned) {
                              context.message(
                                  message: AppStrings.assignmentNotImplemented);
                            } else {
                              context.message(
                                  message: AppStrings
                                      .purchaseRequiredForAssignments);
                            }
                          },
                        );
                      }
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 8.h);
                    },
                  ),
                )
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _launchPaymentUrl(String paymentUrl) async {
    final uri = Uri.parse(paymentUrl);

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Widget get _getFAB {
    return BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
      builder: (context, state) {
        if (state is CourseDetailsLoaded) {
          return SizedBox(
            width: context.width - 32.w,
            height: 50.h,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              onPressed: () {
                if (state.course.isOwned) {
                  context.message(
                      message: AppStrings.continueLearningNotImplemented);
                } else {
                  final userData = MemoryCache.getUserData();
                  if (userData != null) {
                    context.read<CourseDetailsCubit>().buyCourse(
                          userData.id,
                          state.course.id,
                        );
                  } else {
                    context.message(
                        message: "Please login to purchase the course");
                  }
                }
              },
              child: Text(
                state.course.isOwned
                    ? AppStrings.continueLearning
                    : AppStrings.buyCourse,
                style: getRegularStyle(
                  fontSize: 16.sp,
                  color: ThemeColors.textColor,
                ),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

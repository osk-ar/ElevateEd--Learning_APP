import 'dart:developer';

import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:ElevatED/core/constants/app_icons.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/data/data%20sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/assignment/assignment.dart';
import 'package:ElevatED/features/data/models/course/course_category.dart';
import 'package:ElevatED/features/data/models/upload/upload_course_model.dart';
import 'package:ElevatED/features/data/models/view/normalized_course_content.dart';
import 'package:ElevatED/features/presentation/0_common/draggable_fab.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/content_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/cubits/general_cubit.dart';
import 'package:ElevatED/features/presentation/10_create_course/states/general_states.dart';
import 'package:ElevatED/features/presentation/10_create_course/steps/content_step.dart';
import 'package:ElevatED/features/presentation/10_create_course/steps/general_step.dart';
import 'package:ElevatED/features/presentation/10_create_course/steps/pricing_step.dart';
import 'package:ElevatED/features/presentation/10_create_course/widgets/custom_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateCourseScreen extends StatefulWidget {
  const CreateCourseScreen({super.key});

  @override
  State<CreateCourseScreen> createState() => _CreateCourseScreenState();
}

class _CreateCourseScreenState extends State<CreateCourseScreen> {
  late GeneralCubit generalCubit;
  late ContentCubit contentCubit;
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    generalCubit = context.read<GeneralCubit>();
    contentCubit = context.read<ContentCubit>();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  List<Widget> get steps => [
        GeneralStep(
          titleController: _titleController,
          descriptionController: _descriptionController,
        ),
        const ContentStep(),
        PricingStep(
          priceController: _priceController,
        ),
      ];

  List<IconData> get icons => const [
        AppIcons.info,
        AppIcons.content,
        AppIcons.pricing,
      ];

  UploadCourseModel? _createCourseModel() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _priceController.text.isEmpty) {
      context.message(message: "Please fill all general fields");
      return null;
    }
    if (contentCubit.content.isEmpty) {
      context.message(message: "Please add at least one content item");
      return null;
    }
    if (generalCubit.selectedCategoryId == 0) {
      context.message(message: "Please select a category");
      return null;
    }

    final assignments = contentCubit.content
        .whereType<NormalizedCourseAssignment>()
        .map((a) => Assignment(
              index: a.index,
              title: a.title,
              questions: a.questions,
            ))
        .toList();

    final videos = contentCubit.content.whereType<UploadCourseVideo>().toList();

    final category = generalCubit.categories.firstWhere(
      (cat) => cat.id == generalCubit.selectedCategoryId,
    );

    return UploadCourseModel(
      instructorID: MemoryCache.getUserData()!.id,
      price: double.parse(_priceController.text),
      category: CourseCategory(id: category.id, name: category.name),
      courseTitle: _titleController.text,
      courseDescription: _descriptionController.text,
      assignments: assignments,
      videos: videos,
    );
  }

  void _navigateToUpload() {
    final courseModel = _createCourseModel();
    log("courseModel : ${courseModel?.toJson()}");
    if (courseModel != null) {
      context.pushNamed(
        RouteConstants.uploadCourseScreenRoute,
        arguments: courseModel,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                child: BlocBuilder<GeneralCubit, GeneralState>(
                  buildWhen: (previous, current) => current is GeneralNavigated,
                  builder: (context, state) {
                    return RepaintBoundary(
                      child: CustomScrollView(
                        slivers: [
                          //! app bar
                          SliverAppBar(
                            pinned: false,
                            floating: true,
                            elevation: 8.r,
                            shadowColor: ThemeColors.textColor,
                            surfaceTintColor: Colors.transparent,
                            backgroundColor:
                                ThemeColors.lightSurfaceToDarkSecondary,
                            leading: const SizedBox.shrink(),
                            flexibleSpace: FlexibleSpaceBar(
                              title: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: CustomStepper(
                                  activeColor: AppColors.primaryColor,
                                  inActiveColor: AppColors.whiteColor,
                                  circleRadius: 10.r,
                                  lineThickness: 2.w,
                                  iconPadding: 4.r,
                                  stepIcons: icons,
                                  groupIndex: generalCubit.currentIndex,
                                ),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          //! stepper body
                          if (generalCubit.currentIndex == 0)
                            SliverToBoxAdapter(child: steps[0]),
                          if (generalCubit.currentIndex == 1) steps[1],
                          if (generalCubit.currentIndex == 2)
                            SliverToBoxAdapter(child: steps[2]),
                        ],
                      ),
                    );
                  },
                ),
              ),
              //! bottom row
              ColoredBox(
                color: ThemeColors.lightSurfaceToDarkSecondary,
                child: SizedBox(
                  height: 60.h,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          spacing: 16.w,
                          children: [
                            //! delete all button
                            IconButton(
                              color: ThemeColors.warningColor,
                              style: IconButton.styleFrom(
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: ThemeColors.warningColor,
                                    width: 2.r,
                                  ),
                                ),
                              ),
                              onPressed: () => context.showCustomDialog(
                                  primaryColor: ThemeColors.warningColor,
                                  title: AppStrings.removeAll,
                                  content: AppStrings.removeAllConfirmation,
                                  confirmButtonText: AppStrings.reset,
                                  onConfirmPressed: () {
                                    contentCubit.resetContent();
                                    context.pop();
                                  },
                                  cancelButtonText: AppStrings.cancel,
                                  onCancelPressed: () {
                                    context.pop();
                                  }),
                              icon: const Icon(Icons.delete_rounded),
                            ),

                            //! info button
                            BlocBuilder<GeneralCubit, GeneralState>(
                              buildWhen: (previous, current) =>
                                  current is GeneralNavigated,
                              builder: (context, state) {
                                if (state is GeneralNavigated &&
                                    state.index == 1) {
                                  return IconButton(
                                    color: AppColors.whiteColor,
                                    style: IconButton.styleFrom(
                                      shape: CircleBorder(
                                        side: BorderSide(
                                          color: AppColors.whiteColor,
                                          width: 2.r,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                            backgroundColor: ThemeColors
                                                .lightSurfaceToDarkSecondary,
                                            title: const Text('Gestures'),
                                            content: SizedBox(
                                              height: 200.h,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8.w),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    RichText(
                                                      text: TextSpan(
                                                        style: getRegularStyle(
                                                          fontSize: 14.sp,
                                                          color: AppColors
                                                              .whiteColor
                                                              .withAlpha(175),
                                                        ),
                                                        children: [
                                                          TextSpan(
                                                            text: "Ordering: ",
                                                            style: getMediumStyle(
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .whiteColor),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                "drag items up or down to reorder them.\n\n",
                                                          ),
                                                          TextSpan(
                                                            text: "Removing: ",
                                                            style: getMediumStyle(
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .whiteColor),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                "swipe items to the right to remove them.\n\n",
                                                          ),
                                                          TextSpan(
                                                            text: "Editing: ",
                                                            style: getMediumStyle(
                                                                fontSize: 14.sp,
                                                                color: AppColors
                                                                    .whiteColor),
                                                          ),
                                                          const TextSpan(
                                                            text:
                                                                "tap edit icon to edit item's data",
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )),
                                      );
                                    },
                                    icon: const Icon(AppIcons.info),
                                  );
                                }
                                return const SizedBox.shrink();
                              },
                            ),
                          ],
                        ),
                        //! next/prev buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          spacing: 16.w,
                          children: [
                            IconButton(
                              color: AppColors.whiteColor,
                              style: IconButton.styleFrom(
                                shape: CircleBorder(
                                  side: BorderSide(
                                      color: AppColors.whiteColor, width: 2.r),
                                ),
                              ),
                              onPressed: () => generalCubit.previousStep(),
                              icon: const Icon(Icons.arrow_back),
                            ),
                            IconButton(
                              color: AppColors.whiteColor,
                              style: IconButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              onPressed: () {
                                if (generalCubit.currentIndex == 2) {
                                  _navigateToUpload();
                                } else {
                                  generalCubit.nextStep();
                                }
                              },
                              icon: const Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          //! Draggable FAB
          BlocBuilder<GeneralCubit, GeneralState>(
            buildWhen: (previous, current) => current is GeneralNavigated,
            builder: (context, state) {
              if (state is GeneralNavigated && state.index == 1) {
                return DraggableFab(
                  childFabSpacing: 8.h,
                  bottomPadding: 70.h,
                  topPadding: 90.h,
                  leftPadding: 20.w,
                  rightPadding: 20.w,
                  childFabs: [
                    FabItemData(
                      icon: AppIcons.guidelines,
                      onPressed: () {
                        context
                            .pushNamed(RouteConstants.addAssignmentFormRoute);
                      },
                    ),
                    FabItemData(
                      icon: AppIcons.video,
                      onPressed: () {
                        context.pushNamed(RouteConstants.addVideoFormRoute);
                      },
                    ),
                    FabItemData(
                      icon: AppIcons.playlist,
                      onPressed: () async {
                        context.showCustomDialog(
                            title: AppStrings.alert,
                            content: AppStrings.pickingMultipleVideoAlert,
                            confirmButtonText: AppStrings.continueString,
                            onConfirmPressed: () async {
                              context.pop();
                              await contentCubit.pickMultipleVideos(context);
                            },
                            cancelButtonText: AppStrings.cancel,
                            primaryColor: AppColors.primaryColor,
                            onCancelPressed: () {
                              context.pop();
                            });
                      },
                    ),
                  ],
                  screenWidth: MediaQuery.sizeOf(context).width,
                  screenHeight: MediaQuery.sizeOf(context).height,
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

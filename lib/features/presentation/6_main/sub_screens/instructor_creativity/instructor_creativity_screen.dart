import 'package:ElevatED/config/extensions.dart';
import 'package:ElevatED/config/routes/route_constants.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/core/constants/enum.dart';
import 'package:ElevatED/features/presentation/0_common/course_card.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/instructor_creativity_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/states/instructor_creativity_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InstructorCreativityScreen extends StatefulWidget {
  const InstructorCreativityScreen({super.key});

  @override
  State<InstructorCreativityScreen> createState() =>
      _InstructorCreativityScreenState();
}

class _InstructorCreativityScreenState extends State<InstructorCreativityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    context.read<InstructorCreativityCubit>().loadCourses();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.instructorCreativityTitle,
          style: getBoldStyle(
            fontSize: 24.sp,
            color: ThemeColors.textColor,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.h),
          child: Container(
            decoration: BoxDecoration(
              color: ThemeColors.backgroundColor,
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.shadowColor.withAlpha(20),
                  blurRadius: 4,
                  offset: Offset(0, 2.h),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: CourseStatusEnum.uploaded.title),
                Tab(text: CourseStatusEnum.pending.title),
              ],
              labelStyle: getMediumStyle(
                fontSize: 16.sp,
                color: ThemeColors.textColor,
              ),
              unselectedLabelStyle: getRegularStyle(
                fontSize: 16.sp,
                color: ThemeColors.subTextColor,
              ),
              indicatorColor: ThemeColors.secondaryColor,
              indicatorWeight: 3.h,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: ThemeColors.textColor,
              unselectedLabelColor: ThemeColors.subTextColor,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
            ),
          ),
        ),
      ),
      body: BlocBuilder<InstructorCreativityCubit, InstructorCreativityState>(
        builder: (context, state) {
          if (state is InstructorCreativityLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is InstructorCreativityError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48.w,
                    color: ThemeColors.errorColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    state.message,
                    style: getMediumStyle(
                      fontSize: 16.sp,
                      color: ThemeColors.errorColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton.icon(
                    onPressed: () =>
                        context.read<InstructorCreativityCubit>().loadCourses(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.secondaryColor,
                      foregroundColor: ThemeColors.textColor,
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is InstructorCreativityLoaded ||
              state is InstructorCreativityRefreshing) {
            final uploadedCourses = state is InstructorCreativityLoaded
                ? state.uploadedCourses
                : (state as InstructorCreativityRefreshing).uploadedCourses;
            final pendingCourses = state is InstructorCreativityLoaded
                ? state.pendingCourses
                : (state as InstructorCreativityRefreshing).pendingCourses;

            return TabBarView(
              controller: _tabController,
              children: [
                // Uploaded Courses Tab
                _buildCourseList(
                  courses: uploadedCourses,
                  onRefresh: () => context
                      .read<InstructorCreativityCubit>()
                      .refreshCourses(),
                  isRefreshing: state is InstructorCreativityRefreshing,
                ),
                // Pending Courses Tab
                _buildCourseList(
                  courses: pendingCourses,
                  onRefresh: () => context
                      .read<InstructorCreativityCubit>()
                      .refreshCourses(),
                  isRefreshing: state is InstructorCreativityRefreshing,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pushNamed(RouteConstants.createCourseScreenRoute);
        },
        icon: const Icon(Icons.add),
        label: Text(AppStrings.instructorCreativityAddCourse),
        backgroundColor: ThemeColors.secondaryColor,
        foregroundColor: ThemeColors.textColor,
      ),
    );
  }

  Widget _buildCourseList({
    required List<dynamic> courses,
    required Future<void> Function() onRefresh,
    required bool isRefreshing,
  }) {
    if (courses.isEmpty) {
      return Center(
        child: Text(
          AppStrings.instructorCreativityNoCourses,
          style: getMediumStyle(
            fontSize: 16.sp,
            color: ThemeColors.subTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: ListView.builder(
          key: ValueKey(isRefreshing),
          padding: EdgeInsets.all(16.r),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Hero(
                tag: 'course_${courses[index].id}',
                child: CourseCard(course: courses[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

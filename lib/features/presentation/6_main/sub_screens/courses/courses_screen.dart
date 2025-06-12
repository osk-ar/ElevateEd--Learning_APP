import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/courses_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/states/courses_state.dart';
import 'package:ElevatED/features/presentation/0_common/course_card.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/courses/widgets/category_filter.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/courses/widgets/loading_course_card.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/courses/widgets/error_widget.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/courses/widgets/empty_courses_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _scrollController.addListener(_handleScroll);
    context.read<CoursesCubit>().loadCourses();
  }

  void _handleTabChange() {
    if (_tabController.indexIsChanging) {
      context.read<CoursesCubit>().switchTab(_tabController.index == 1);
    }
  }

  void _handleScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 100.h) {
      context.read<CoursesCubit>().loadMoreCourses();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.courses),
        centerTitle: true,
        leading: const SizedBox.shrink(),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: AppStrings.allCourses),
            Tab(text: AppStrings.myCourses),
          ],
        ),
      ),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          if (state is CoursesInitial || state is CoursesLoading) {
            return _buildLoadingState();
          } else if (state is CoursesError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => context.read<CoursesCubit>().loadCourses(),
            );
          } else if (state is CoursesLoaded) {
            if (state.courses.isEmpty) {
              return EmptyCoursesWidget(
                isPurchasedTab: state.isPurchasedTab,
              );
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<CoursesCubit>().loadCourses();
              },
              child: Column(
                children: [
                  if (!state.isPurchasedTab)
                    CategoryFilter(
                      categories: state.categories,
                    ),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.all(16.r),
                      itemCount: state.courses.length + (state.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == state.courses.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: CourseCard(course: state.courses[index]),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CoursesLoadingMore) {
            return Column(
              children: [
                if (!state.isPurchasedTab)
                  CategoryFilter(
                    categories: state.categories,
                  ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(16.r),
                    itemCount: state.courses.length + 1,
                    itemBuilder: (context, index) {
                      if (index == state.courses.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: CourseCard(course: state.courses[index]),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: const LoadingCourseCard(),
        );
      },
    );
  }
}

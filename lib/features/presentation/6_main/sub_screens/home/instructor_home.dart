import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/data/models/data_point.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/widgets/home_appbar.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/widgets/home_progress_snippet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/stats_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/widgets/line_chart_container.dart';
import 'package:ElevatED/core/constants/enum.dart';

class InstructorHome extends StatefulWidget {
  const InstructorHome({super.key});

  @override
  State<InstructorHome> createState() => _InstructorHomeState();
}

class _InstructorHomeState extends State<InstructorHome> {
  @override
  void initState() {
    super.initState();
    context.read<StatsCubit>().loadUserActivityPoints();
  }

  @override
  Widget build(BuildContext context) {
    final userData = MemoryCache.getUserData() as InstructorUserData;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            SizedBox(height: 24.h),
            HomeAppbar(name: userData.name, role: UserRoleEnum.instructor),
            SizedBox(height: 16.h),

            // Activity Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Activity Stats",
                  style: getBoldStyle(
                    fontSize: 16.sp,
                    color: ThemeColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            HomeProgressSnippet(
              progressPoints: userData.revenuePoints.isEmpty
                  ? [
                      DataPoint(
                        dateTime:
                            DateTime.now().subtract(const Duration(days: 2)),
                        value: 0,
                      ),
                      DataPoint(
                        dateTime:
                            DateTime.now().subtract(const Duration(days: 1)),
                        value: 0,
                      ),
                      DataPoint(
                        dateTime: DateTime.now(),
                        value: 0,
                      ),
                    ]
                  : userData.revenuePoints,
              totalRecentProgress: userData.revenuePoints.isEmpty
                  ? 0
                  : userData.revenuePoints
                      .map((point) => point.value)
                      .reduce((a, b) => a + b)
                      .round(),
              title: "Recent Progress",
              valueExtention: "\$",
            ),
            SizedBox(height: 24.h),

            // Revenue Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Revenue Stats",
                  style: getBoldStyle(
                    fontSize: 16.sp,
                    color: ThemeColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Container(
              height: 330.h,
              decoration: BoxDecoration(
                color: ThemeColors.backgroundColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(20),
                    blurRadius: 10,
                    offset: Offset(0, 4.h),
                  ),
                ],
              ),
              child: BlocBuilder<StatsCubit, StatsState>(
                buildWhen: (prev, curr) =>
                    curr is StatsLoaded || curr is StatsError,
                builder: (context, state) {
                  if (state is StatsLoaded) {
                    return PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      controller:
                          PageController(initialPage: 1, keepPage: true),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.w),
                          child: LineChartContainer(
                            rawData: context
                                .read<StatsCubit>()
                                .getRawData(state.activityPoints, index),
                            chartRange: ChartRangeEnum.values[index],
                          ),
                        );
                      },
                    );
                  } else if (state is StatsError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: getRegularStyle(
                          fontSize: 14.sp,
                          color: ThemeColors.textColor,
                        ),
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

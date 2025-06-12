import 'package:ElevatED/core/constants/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/config/themes/text_styles.dart';
import 'package:ElevatED/features/data/data sources/cache/memory_cache.dart';
import 'package:ElevatED/features/data/models/user_data.dart';
import 'package:ElevatED/features/presentation/6_main/cubits/stats_cubit.dart';
import 'package:ElevatED/features/presentation/6_main/sub_screens/home/widgets/line_chart_container.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  @override
  void initState() {
    super.initState();
    context.read<StatsCubit>().loadUserActivityPoints();
  }

  @override
  Widget build(BuildContext context) {
    final userData = MemoryCache.getUserData() as StudentUserData;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Section
            Text(
              "Welcome, ${userData.name}",
              style: getBoldStyle(
                fontSize: 24.sp,
                color: ThemeColors.textColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              "Track your learning progress",
              style: getRegularStyle(
                fontSize: 16.sp,
                color: ThemeColors.subTextColor,
              ),
            ),
            SizedBox(height: 24.h),

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
            Container(
              height: 330.h,
              decoration: BoxDecoration(
                color: ThemeColors.backgroundColor,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
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

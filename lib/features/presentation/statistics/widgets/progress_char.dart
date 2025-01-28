import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_styles.dart';
import 'package:e_learning_app_gp/features/presentation/common/stats_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProgressChar extends StatelessWidget {
  const ProgressChar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: MyTheme.charBackground,
      ),
      child: Column(
        children: [
          // TODO -> change this to an expand icon button
          SizedBox(height: 16.h),
          Text(
            'This Week',
            style: getMediumStyle(
                fontSize: 20.sp, color: MyTheme.inverseTextColor),
          ),
          SizedBox(height: 8.h),
          Text(
            '52h 24m',
            style:
                getBoldStyle(fontSize: 24.sp, color: MyTheme.inverseTextColor),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(7, (index) {
              return Column(
                children: [
                  Text(
                    '+${[10, 9, 6, 5, 6, 4, 8][index]}',
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  StatsBar(
                    topColor: MyTheme.secondaryColor,
                    bottomColor: MyTheme.primaryColor,
                    duration: 500,
                    isToday: index == 3,
                    gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [MyTheme.surfaceColor, MyTheme.primaryColor]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              );
            }),
          ),
          SizedBox(height: 24.h),
        ],
      ),
    );
  }
}

import 'package:e_learning_app_gp/config/themes/theme.dart';
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
          Text(
            'This Week',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            '52h 24m',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
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
                  CharBar(
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

class CharBar extends StatelessWidget {
  const CharBar(
      {super.key,
      this.topColor,
      this.bottomColor,
      this.gradient,
      this.duration,
      this.isToday = false});
  final Color? topColor;
  final Color? bottomColor;
  final LinearGradient? gradient;
  final int? duration;
  final bool isToday;

  @override
  Widget build(BuildContext context) {
    final double height = 100.h;
    final double width = 36.w;
    final double borderRadius = 8.r;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AnimatedContainer(
          width: width,
          height: isToday ? height + 3.h : height,
          duration: Duration(milliseconds: duration ?? 300),
          decoration: BoxDecoration(
            color: bottomColor,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        AnimatedContainer(
          width: width,
          height: height,
          duration: Duration(milliseconds: duration ?? 300),
          decoration: BoxDecoration(
            color: topColor,
            gradient: gradient,
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ],
    );
  }
}

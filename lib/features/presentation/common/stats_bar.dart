import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatsBar extends StatelessWidget {
  const StatsBar(
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

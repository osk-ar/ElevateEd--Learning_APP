import 'package:ElevatED/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoubleCircularAvatar extends StatelessWidget {
  final Widget child;
  final double? innerRadius;
  final double? outerRadius;
  const DoubleCircularAvatar({
    super.key,
    required this.child,
    this.innerRadius,
    this.outerRadius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius ?? 61.r,
      backgroundColor: AppColors.lightFadedPrimaryColor,
      child: CircleAvatar(
          radius: innerRadius ?? 46.r,
          backgroundColor: AppColors.primaryColor,
          child: child),
    );
  }
}

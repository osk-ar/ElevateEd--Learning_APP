import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoubleCircularAvatar extends StatelessWidget {
  final Widget? child;
  final String? imageURL;
  final double? innerRadius;
  final double? outerRadius;
  const DoubleCircularAvatar({
    super.key,
    this.child,
    this.innerRadius,
    this.outerRadius,
    this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: outerRadius ?? 61.r,
      backgroundColor: AppColors.fadedPrimaryColor,
      child: CircleAvatar(
          radius: innerRadius ?? 46.r,
          backgroundColor: AppColors.primaryColor,
          backgroundImage: imageURL != null ? NetworkImage(imageURL!) : null,
          child: child),
    );
  }
}

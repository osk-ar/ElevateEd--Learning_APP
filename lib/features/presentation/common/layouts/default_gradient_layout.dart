import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class DefaultGradientLayout extends StatelessWidget {
  final Widget? child;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final bool? scrollable;
  final Gradient gradient;

  const DefaultGradientLayout(
      {super.key,
      this.topPadding = 42,
      this.bottomPadding = 42,
      this.leftPadding = 12,
      this.rightPadding = 12,
      this.scrollable = false,
      this.child,
      required this.gradient});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Padding(
        padding: EdgeInsets.only(
            top: topPadding!.h,
            bottom: bottomPadding!.h,
            left: leftPadding!.w,
            right: rightPadding!.w),
        child: !scrollable!
            ? child
            : SingleChildScrollView(
                child: child,
              ),
      ),
    );
  }
}

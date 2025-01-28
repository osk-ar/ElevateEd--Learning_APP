import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final bool scrollable;

  const DefaultLayout(
      {super.key,
      this.topPadding = 42,
      this.bottomPadding = 42,
      this.leftPadding = 16,
      this.rightPadding = 16,
      this.scrollable = false,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: topPadding!.h,
          bottom: bottomPadding!.h,
          left: leftPadding!.w,
          right: rightPadding!.w),
      child: !scrollable
          ? child
          : SingleChildScrollView(
              child: child,
            ),
    );
  }
}

import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final bool? scrollable;

  const DefaultLayout(
      {super.key,
      this.topPadding = 42,
      this.bottomPadding = 42,
      this.leftPadding = 12,
      this.rightPadding = 12,
      this.scrollable = false,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MyTheme.backgroundColor,
      body: Padding(
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

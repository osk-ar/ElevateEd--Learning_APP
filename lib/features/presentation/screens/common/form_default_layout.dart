import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormDefaultLayout extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final double? topPadding;
  final double? bottomPadding;
  final double? leftPadding;
  final double? rightPadding;
  final bool? scrollable;

  const FormDefaultLayout(
      {super.key,
      required this.formKey,
      required this.children,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.crossAxisAlignment = CrossAxisAlignment.center,
      this.topPadding = 42,
      this.bottomPadding = 42,
      this.leftPadding = 12,
      this.rightPadding = 12,
      this.scrollable = false});

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
        child: Form(
          key: formKey,
          child: !scrollable!
              ? Column(
                  mainAxisAlignment: mainAxisAlignment,
                  crossAxisAlignment: crossAxisAlignment,
                  children: children,
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: mainAxisAlignment,
                    crossAxisAlignment: crossAxisAlignment,
                    children: children,
                  ),
                ),
        ),
      ),
    );
  }
}

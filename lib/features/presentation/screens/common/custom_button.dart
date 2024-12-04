import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    required this.colorText,
    this.borderColor = Colors.transparent,
    this.width,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color colorText;
  final double? width;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: width ?? AppSize.s335.w,
        height: AppSize.s60.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: color,
            splashFactory: InkRipple.splashFactory,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppBorderRadius.bigBorderRadius.r),
              side: BorderSide(color: borderColor),
            ),
          ),
          child: Text(
            text,
            style:
                AppTextStyles.customButtonTextStyle(context, color: colorText),
          ),
        ),
      ),
    );
  }
}

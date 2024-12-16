import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:e_learning_app_gp/core/resources/app_colors.dart';
import 'package:e_learning_app_gp/core/resources/app_fonts.dart';
import 'package:e_learning_app_gp/core/resources/app_values.dart';
import 'package:e_learning_app_gp/core/resources/assets_manager.dart';
import 'package:e_learning_app_gp/core/resources/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Social extends StatelessWidget {
  final void Function()? onTapFacebook;
  final void Function()? onTapGoogle;
  const Social({
    super.key,
    this.onTapFacebook,
    this.onTapGoogle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomButtonSocial(
          text: "Login with Facebook",
          icon: SvgPicture.asset(SVGAssets.facebook),
          onTap: onTapFacebook ?? () {},
        ),
        SizedBox(height: AppSize.s20.h),
        CustomButtonSocial(
          text: "Login with Google",
          icon: SvgPicture.asset(SVGAssets.google),
          onTap: onTapGoogle ?? () {},
        ),
      ],
    );
  }
}

class CustomButtonSocial extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Widget? icon;

  const CustomButtonSocial({
    super.key,
    required this.text,
    this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppPadding.mediumPadding.r),
        width: AppSize.s350.w,
        height: AppSize.s50.h,
        decoration: BoxDecoration(
          border: Border.all(color: MyTheme.primaryColor),
          borderRadius: BorderRadius.circular(AppSize.s10.r),
          color: MyTheme.secondaryColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon ?? const SizedBox.shrink(),
            SizedBox(width: AppSize.s48.w),
            Text(
              text,
              style: AppTextStyles.regularTextStyle(context,
                  fontSize: FontSize.f16),
            ),
          ],
        ),
      ),
    );
  }
}

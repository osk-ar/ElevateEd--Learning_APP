import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget(
      {super.key,
      this.iconSize,
      this.radius,
      this.borderWidth,
      this.onTap,
      required this.imageExist,
      this.imageFile});
  final double? iconSize;
  final double? radius;
  final double? borderWidth;
  final void Function()? onTap;
  final bool imageExist;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.fadedPrimaryColor,
      minRadius: (radius ?? 61.r) + (borderWidth ?? 6.r),
      maxRadius: (radius ?? 61.r) + (borderWidth ?? 6.r),
      child: CircleAvatar(
        minRadius: radius ?? 61.r,
        maxRadius: radius ?? 61.r,
        backgroundColor: AppColors.primaryColor,
        backgroundImage: imageExist ? FileImage(imageFile!) : null,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            imageExist
                ? const SizedBox()
                : Icon(
                    Icons.add,
                    size: iconSize ?? 24.r,
                    color: ThemeColors.inverseTextColor,
                  ),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(
                  (radius ?? 61.r) + (borderWidth ?? 6.r)),
            )
          ],
        ),
      ),
    );
  }
}

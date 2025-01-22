import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ImagePicker extends StatelessWidget {
  const ImagePicker(
      {super.key,
      required this.iconSize,
      required this.radius,
      required this.borderWidth,
      this.onTap,
      required this.imageExist,
      this.imageFile});
  final double iconSize;
  final double radius;
  final double borderWidth;
  final void Function()? onTap;
  final bool imageExist;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: MyTheme.primaryColor,
      minRadius: radius + borderWidth,
      maxRadius: radius + borderWidth,
      child: CircleAvatar(
        minRadius: radius,
        maxRadius: radius,
        backgroundColor: MyTheme.secondaryColor,
        backgroundImage: imageExist ? FileImage(imageFile!) : null,
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            imageExist
                ? const SizedBox()
                : Icon(
                    Icons.add,
                    size: iconSize,
                    color: MyTheme.onSecondaryColor,
                  ),
            InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(radius + borderWidth),
            )
          ],
        ),
      ),
    );
  }
}

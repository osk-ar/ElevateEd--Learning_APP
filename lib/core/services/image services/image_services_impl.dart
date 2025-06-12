import 'dart:developer';
import 'dart:io';
import 'package:ElevatED/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:ElevatED/config/themes/theme_colors.dart';
import 'package:ElevatED/core/services/image%20services/image_services.dart';

class ImageServicesImpl implements ImageServices {
  @override
  Future<XFile?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    return image;
  }

  @override
  Future<File?> cropImage(BuildContext context, String imagePath) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: imagePath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 50,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: AppStrings.cropImage,
          toolbarColor: MyTheme.backgroundColor,
          toolbarWidgetColor: MyTheme.textColor,
          activeControlsWidgetColor: MyTheme.primaryColor,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
        IOSUiSettings(
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio16x9,
          ],
        ),
        WebUiSettings(
          context: context,
          presentStyle: WebPresentStyle.dialog,
          size: const CropperSize(
            width: 520,
            height: 520,
          ),
        ),
      ],
    );

    if (croppedFile == null) {
      return null;
    }
    log("path: ${croppedFile.path}");

    return File(croppedFile.path);
  }
}

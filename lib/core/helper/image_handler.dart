import 'dart:io';
import 'dart:typed_data';

import 'package:e_learning_app_gp/config/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageHandler {
  static Future<File?> pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      return null;
    }
    print("image selected!");

    String? croppedImagePath;
    if (context.mounted) {
      croppedImagePath = await _cropImage(context, image);
    }
    if (croppedImagePath == null) {
      return null;
    }
    print("image cropped!");

    File scaledProfileImage = await _convertAndScaleImage(croppedImagePath);
    print("image scaled!");
    return scaledProfileImage;
  }

  static Future<String?> _cropImage(BuildContext context, XFile image) async {
    final CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Image Editor',
          toolbarColor: MyTheme.backgroundColor,
          toolbarWidgetColor: MyTheme.textColor,
          activeControlsWidgetColor: MyTheme.primaryColor,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
          ],
        ),
        IOSUiSettings(
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
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
    if (croppedFile != null) {
      return croppedFile.path;
    }
    return null;
  }

  static Future<File> _convertAndScaleImage(String path) async {
    // Read the Cropped File
    File imageFile = File(path);
    // Convert to Image File
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image image = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // Convert to JPG
    List<int> jpgBytes = img.encodeJpg(image);

    // Save the resized JPG image to a new file
    String newPath =
        imageFile.path.replaceAll('.png', '_scaled.jpg'); // Save as .jpg
    File resizedImageFile = File(newPath)..writeAsBytesSync(jpgBytes);

    return resizedImageFile;
  }
}

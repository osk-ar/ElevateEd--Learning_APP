import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class ImageServices {
  Future<XFile?> pickImage();
  Future<File?> cropImage(BuildContext context, String imagePath);
}

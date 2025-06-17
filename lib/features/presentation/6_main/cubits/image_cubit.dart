import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ElevatED/core/services/image%20services/image_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part '../states/image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  ImageCubit(this._imageServices) : super(ImageInitial());
  final ImageServices _imageServices;

  File? profileImage;

  Future<void> selectImage(BuildContext context) async {
    try {
      final image = await _imageServices.pickImage();
      if (image == null) return;

      final croppedImage = await _imageServices.cropImage(context, image.path);
      if (croppedImage == null) return;

      profileImage = croppedImage;
      emit(ImageUpdated(profileImage!));
    } catch (e) {
      emit(ImageError(e.toString()));
    }
  }

  void clearImage() {
    profileImage = null;
    emit(ImageCleared());
  }

  bool get hasImage => profileImage != null;
}

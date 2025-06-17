part of '../cubits/image_cubit.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object?> get props => [];
}

class ImageInitial extends ImageState {}

class ImageUpdated extends ImageState {
  final File imageFile;
  const ImageUpdated(this.imageFile);
  @override
  List<Object?> get props => [imageFile];
}

class ImageCleared extends ImageState {}

class ImageError extends ImageState {
  final String message;
  const ImageError(this.message);
  @override
  List<Object?> get props => [message];
}

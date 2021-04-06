import 'package:tutor_search_system/models/image.dart';

abstract class ImageState {}

class InitialImageState extends ImageState {}

class ImageErrorState extends ImageState {
  final String errorMessage;

  ImageErrorState(this.errorMessage);
}

class ImageLoadedState extends ImageState {
  final Image image;

  ImageLoadedState(this.image);
}

class ImageListLoadedState extends ImageState {
  final String images;

  ImageListLoadedState(this.images);
}

class ImageNoDataState extends ImageState {}

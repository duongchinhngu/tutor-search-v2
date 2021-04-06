import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/image.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/repositories/image_repository.dart';
import 'package:tutor_search_system/states/image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  final ImageRepository _repository;
  ImageCubit(this._repository)
      : super(InitialImageState());

  //get all active class by subject id
  Future getImageByEmail(String email, String imageType) async {
    
    try {
      String images = await _repository
          .fetchImageByEmail(http.Client(), email, imageType);
         
      if (images == null) {
        emit(ImageNoDataState());
      } else {
        emit(ImageListLoadedState(images));
      }
    } catch (e) {
      emit(ImageErrorState('$e'));
    }
  }
}

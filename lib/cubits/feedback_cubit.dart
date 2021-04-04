import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/feedback.dart';
import 'package:tutor_search_system/repositories/feedback_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final FeedbackRepository _repository;
  FeedbackCubit(this._repository)
      : super(InitialFeedbackState());

  //get all active class by subject id
  Future getFeedbackByTutorId(int tuteeId) async {
    try {
      List<Feedbacks> feedbackes = await _repository
          .fetchFeedbackByTutorId(http.Client(), tuteeId);
      if (feedbackes == null) {
        emit(FeedbackNoDataState());
      } else {
        emit(FeedbackListLoadedState(feedbackes));
      }
    } catch (e) {
      emit(FeedbackErrorState('$e'));
    }
  }
}

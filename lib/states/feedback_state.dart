import 'package:tutor_search_system/models/feedback.dart';

abstract class FeedbackState {}

class InitialFeedbackState extends FeedbackState {}

class FeedbackErrorState extends FeedbackState {
  final String errorMessage;

  FeedbackErrorState(this.errorMessage);
}

class FeedbackLoadedState extends FeedbackState {
  final Feedbacks feedback;

  FeedbackLoadedState(this.feedback);
}

class FeedbackListLoadedState extends FeedbackState {
  final List<Feedbacks> feedbacks;

  FeedbackListLoadedState(this.feedbacks);
}

class FeedbackNoDataState extends FeedbackState {}

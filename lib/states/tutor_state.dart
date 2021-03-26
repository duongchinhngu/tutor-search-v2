import 'package:tutor_search_system/models/extended_models/extended_tutor.dart';
import 'package:tutor_search_system/models/tutor.dart';

abstract class TutorState {}

class TutorLoadingState extends TutorState {}

class TutorLoadedState extends TutorState {
  final Tutor tutor;

  TutorLoadedState(this.tutor);
}

class ExtendedTutorLoadedState extends TutorState {
  final ExtendedTutor tutor;

  ExtendedTutorLoadedState(this.tutor);
}

class TutorLoadFailedState extends TutorState {
  final String errorMessage;

  TutorLoadFailedState(this.errorMessage);
}

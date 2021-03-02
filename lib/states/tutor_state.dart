import 'package:tutor_search_system/models/tutor.dart';

abstract class TutorState {}

class TutorLoadingState extends TutorState {}

class TutorLoadedState extends TutorState {
  final Tutor tutor;

  TutorLoadedState(this.tutor);
}

class TutorLoadFailedState extends TutorState {
  final String errorMessage;

  TutorLoadFailedState(this.errorMessage);
}

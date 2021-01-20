import 'package:tutor_search_system/models/tutee.dart';

abstract class TuteeState {}

class TuteeLoadingState extends TuteeState {}

class TuteeLoadedState {
  final Tutee tutee;

  TuteeLoadedState(this.tutee);
}

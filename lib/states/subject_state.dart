import 'package:tutor_search_system/models/subject.dart';

abstract class SubjectState {}

class SubjectLoadingState extends SubjectState {}

class SubjectLoadedState extends SubjectState {
  final Subject subject;

  SubjectLoadedState(this.subject);
}

class SubjectListLoadedState extends SubjectState {
  List<Subject> subjects;

  SubjectListLoadedState(this.subjects);
}

class SubjectLoadFailedState extends SubjectState {
  final String errorMessage;

  SubjectLoadFailedState(this.errorMessage);
}
import 'package:tutor_search_system/models/class_has_subject.dart';

abstract class ClassHasSubjectState {}

class ClassHasSubjectLoadingState extends ClassHasSubjectState {}

class ClassHasSubjectErrorState extends ClassHasSubjectState {
  final String errorMessage;

  ClassHasSubjectErrorState(this.errorMessage);
}

class ClassHasSubjectLoadedState extends ClassHasSubjectState {
  final ClassHasSubject classHasSubject;

  ClassHasSubjectLoadedState(this.classHasSubject);
}

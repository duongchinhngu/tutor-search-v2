import 'package:tutor_search_system/models/class.dart';

abstract class ClassState {}

class ClassLoadingState extends ClassState {}

class ClassLoadedState extends ClassState {
  final Class _class;

  ClassLoadedState(this._class);
}

class ClassListLoadedState extends ClassState {
  final List<Class> classes;

  ClassListLoadedState(this.classes);
}

class ClassesLoadFailedState extends ClassState {
  final String errorMessage;

  ClassesLoadFailedState(this.errorMessage);
}

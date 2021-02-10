import 'package:tutor_search_system/models/fee.dart';

abstract class FeeState {}

class FeeLoadingState extends FeeState {}

class FeeErrorState extends FeeState {
  final String errorMessage;

  FeeErrorState(this.errorMessage);
}

class FeeLoadedState extends FeeState {
  final Fee fee;

  FeeLoadedState(this.fee);
}

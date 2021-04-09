import 'package:tutor_search_system/models/commission.dart';

abstract class CommissionState {}

class CommissionLoadingState extends CommissionState {}

class CommissionErrorState extends CommissionState {
  final String errorMessage;

  CommissionErrorState(this.errorMessage);
}

class CommissionLoadedState extends CommissionState {
  final Commission commission;

  CommissionLoadedState(this.commission);
}

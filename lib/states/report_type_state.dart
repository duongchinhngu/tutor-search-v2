import 'package:tutor_search_system/models/report_type.dart';

abstract class ReportTypeState {}

class ReportTypeLoadingState extends ReportTypeState {}

class ReportTypeLoadedState extends ReportTypeState {
  final ReportType reportType;

  ReportTypeLoadedState(this.reportType);
}

class ReportTypeListLoadedState extends ReportTypeState {
  List<ReportType> reportTypes;

  ReportTypeListLoadedState(this.reportTypes);
}

class ReportTypeLoadFailedState extends ReportTypeState {
  final String errorMessage;

  ReportTypeLoadFailedState(this.errorMessage);
}

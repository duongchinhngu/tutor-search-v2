import 'package:tutor_search_system/models/tutor_report.dart';

abstract class TutorReportState {}

class TutorReportLoadingState extends TutorReportState {}

class TutorReportLoadedState extends TutorReportState {
  final TutorReport tutorReport;

  TutorReportLoadedState(this.tutorReport);
}

class TutorReportListLoadedState extends TutorReportState {
  List<TutorReport> tutorReports;

  TutorReportListLoadedState(this.tutorReports);
}

class TutorReportLoadFailedState extends TutorReportState {
  final String errorMessage;

  TutorReportLoadFailedState(this.errorMessage);
}

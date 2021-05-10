import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:tutor_search_system/repositories/tutor_report_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/tutor_report_state.dart';

class TutorReportCubit extends Cubit<TutorReportState> {
  TutorReportRepository _repository;
  TutorReportCubit(this._repository) : super(TutorReportLoadingState());

 
}
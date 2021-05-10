import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:tutor_search_system/repositories/report_type_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/states/report_type_state.dart';

class ReportTypeCubit extends Cubit<ReportTypeState> {
  ReportTypeRepository _repository;
  ReportTypeCubit(this._repository) : super(ReportTypeLoadingState());

 
}
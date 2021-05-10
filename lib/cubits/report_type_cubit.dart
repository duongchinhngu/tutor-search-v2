import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/report_type.dart';
import 'package:tutor_search_system/repositories/report_type_repository.dart';
import 'package:tutor_search_system/states/report_type_state.dart';

class ReportTypeCubit extends Cubit<ReportTypeState> {
  ReportTypeRepository _repository;
  ReportTypeCubit(this._repository) : super(ReportTypeLoadingState());

  //get all active class by subject id
  Future getReportType(int roleId) async {
    try {
      List<ReportType> reportTypes = await _repository.fetchReportType(roleId);
      if (reportTypes != null) {
        emit(ReportTypeListLoadedState(reportTypes));
      } else {
        emit(ReportTypeNoDataState());
      }
    } catch (e) {
      emit(ReportTypeLoadFailedState('$e'));
    }
  }
}

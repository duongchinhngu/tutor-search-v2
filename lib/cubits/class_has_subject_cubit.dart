import 'package:bloc/bloc.dart';
import 'package:tutor_search_system/models/class_has_subject.dart';
import 'package:tutor_search_system/repositories/class_has_subject_repository.dart';
import 'package:tutor_search_system/states/class_has_subject_state.dart';
import 'package:http/http.dart' as http;

class ClassHasSubjectCubit extends Cubit<ClassHasSubjectState> {
  ClassHasSubjectRepository _repository;
  ClassHasSubjectCubit(this._repository) : super(ClassHasSubjectLoadingState());

  //get class has subject by subject id and class id
  Future getClassHasSubjectBySubjectIdClassId(int subjectId, int classId) async {
    try {
      ClassHasSubject classHasSubject = await _repository.fetchClassHasSubjectBySubjectIdClassId(http.Client(), subjectId, classId);
      emit(ClassHasSubjectLoadedState(classHasSubject));
    } catch (e) {
      emit(ClassHasSubjectErrorState('$e'));
    }
  }
}
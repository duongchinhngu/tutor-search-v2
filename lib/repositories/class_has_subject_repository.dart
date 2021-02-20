import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/class_has_subject.dart';

class ClassHasSubjectRepository {
  //get classhassubject by subject id and class id
  Future<ClassHasSubject> fetchClassHasSubjectBySubjectIdClassId(
      http.Client client, int subjectId, int classId) async {
    final response = await http.get('$SEARCH_CLASS_HAS_SUBJECT_API/result?subjectId=$subjectId&classId=$classId');
    if (response.statusCode == 200) {
      return ClassHasSubject.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to fetch class has subject by subject and class id');
    }
  }
}

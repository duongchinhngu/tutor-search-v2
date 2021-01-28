import 'package:tutor_search_system/models/subject.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';

class SubjectRepository {
  //fetch all subjects
  Future<List<Subject>> fetchAllSubjects(http.Client client) async {
    final response = await http.get('$ALL_SUBJECT_API');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((subjects) => new Subject.fromJson(subjects))
          .toList();
    } else {
      throw Exception('Failed to fetch all Subjects');
    }
  }
}

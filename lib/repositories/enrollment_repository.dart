import 'dart:convert';

import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:http/http.dart' as http;

class EnrollmentRepository {
  //add new Enrollment in DB, set status is Pending
  Future postEnrollment(Enrollment enrollment) async {
    final http.Response response = await http.post(ENROLLMENT_API,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': enrollment.id,
            'description': enrollment.description,
            'status': enrollment.status,
            'tuteeId': enrollment.tuteeId,
            'courseId': enrollment.courseId,
          },
        ));
    if (response.statusCode == 201 || response.statusCode == 204 || response.statusCode == 404) {
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Faild to post Enrollment');
    }
  }
}
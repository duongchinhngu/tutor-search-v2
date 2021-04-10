import 'dart:convert';

import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/enrollment.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/enrollment_course.dart';

class EnrollmentRepository {
  //add new Enrollment in DB, set status is Pending
  Future postEnrollment(Enrollment enrollment) async {
    final http.Response response = await http.post(ENROLLMENT_API,
        headers: await AuthorizationContants().getAuthorizeHeader(),
        body: jsonEncode(
          <String, dynamic>{
            'id': enrollment.id,
            'description': enrollment.description,
            'status': enrollment.status,
            'tuteeId': enrollment.tuteeId,
            'courseId': enrollment.courseId,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      return true;
    } else {
      print("Error body: " + response.body);
      throw Exception(
          'Faild to post Enrollment' + response.statusCode.toString());
    }
  }

  Future<List<CourseEnrollment>> fetchCourseEnrollmentByTutorIdForMonth(
      int tutorId, String currentDate) async {
    final response = await http.get(
      '$ENROLLMENT_API/tutorId/toDate/$tutorId/$currentDate',
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courseenroll) => new CourseEnrollment.fromJson(courseenroll))
          .toList();
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception(
          'Failed to CourseEnrollment by tutorid and date: ' + response.body);
    }
  }

  //get enrollment by tuteeId and courseId
  Future<Enrollment> fetchEnrollmentByCourseIdTuteeId(
      int courseId, int tuteeId) async {
    final response =
        await http.get('$ENROLLMENT_API/course/tutee/$courseId/$tuteeId');
    if (response.statusCode == 200) {
      return Enrollment.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception(
          'Failed to Enrollment by courseid and tutee id: ' + response.body);
    }
  }

  //get enrollment by enroolemntId
  Future<Enrollment> fetchEnrollmentById(int id) async {
    final response = await http.get('$ENROLLMENT_API/$id');
    if (response.statusCode == 200) {
      return Enrollment.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to Enrollment by Id: ' + response.body);
    }
  }

  //update enrollment in db
  Future<bool> putEnrollment(Enrollment enrollment) async {
    final response = await http.put(
      '$ENROLLMENT_API/${enrollment.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': enrollment.id,
        'tuteeId': enrollment.tuteeId,
        'courseId': enrollment.courseId,
        'description': enrollment.description,
        'status': enrollment.status,
        'createdDate': enrollment.createdDate,
        'confirmedDate': enrollment.confirmedDate,
      }),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Error enrollment update body: ' + response.body);
      throw new Exception('Update enrollment failed!: ${response.statusCode}');
    }
  }

  //update enrollment in db
  Future<bool> checkFullCourse(int courseId) async {
    final response = await http.put(
      '$ENROLLMENT_API/check-full-course/$courseId',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'courseId': courseId,
      }),
    );
    if (response.statusCode == 204) {
      return true;
    } else {
      print('Error enrollment check full course: ' + response.body);
      throw new Exception('check full course failed!: ${response.statusCode}');
    }
  }
}

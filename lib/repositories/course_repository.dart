import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/course.dart';
import 'package:tutor_search_system/commons/global_variables.dart' as globals;

class CourseRepository {
  //fetch all active course courses, fetch courses that isn't followed by this tutee
  Future<List<Course>> fetchAllCourses(http.Client client) async {
    final response = await http.get('$ALL_COURSE_API');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    } else {
      throw Exception('Failed to fetch all courses');
    }
  }

  //fecth all courses : status = active and not registered by this tuteeId
  Future<List<Course>> fecthTuteeHomeCourses(http.Client client) async {
    final tuteeId = globals.authorizedTutee.id;
    final response = await http.get('$TUTEE_HOME_COURSES/$tuteeId');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    } else {
      throw Exception('Failed to fetch all courses');
    }
  }

  //fetch courses by status
  Future<List<Course>> fetchCourseByFilter(
      http.Client client, String status, int subjectId) async {
    //host url
    String url = FILTER_COURSE_API;
    //query parameters
    Map<String, String> queryParams = {
      'status': status,
      'subjectId': subjectId.toString(),
    };
    //transform to queryTring
    String queryString = Uri(queryParameters: queryParams).query;
    url += queryString;
    print('this is query url: ' + url);
    //merge to url

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    } else {
      throw Exception('Failed to fetch courses by filter');
    }
  }

  //fetch courses unregistered by tuteeId; by subjectId and classId
  Future<List<Course>> fetchgetUnregisteredCoursesBySubjectIdClassId(
      http.Client client, int tuteeId, int subjectId, int classId) async {
    //host url
    String url = UNREGISTERD_COURSE_BY_SUBJECT_CLASS_API;
    //query parameters
    Map<String, String> queryParams = {
      'tuteeId': tuteeId.toString(),
      'subjectId': subjectId.toString(),
      'classId': classId.toString(),
    };
    //transform to queryTring
    String queryString = Uri(queryParameters: queryParams).query;
    url += queryString;
    print('this is query url: ' + url);
    //merge to url

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    } else {
      print('error body: ' + response.body);
      throw Exception('Failed to fetch courses by filter');
    }
  }

  //fetch courses by courseId
  Future<Course> fetchCourseByCourseId(http.Client client, int id) async {
    final response = await http.get('$COURSE_API/$id');
    if (response.statusCode == 200) {
      return Course.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch course by course id');
    }
  }

  //fetch courses by tuteeId, enrollment status
  Future<List<Course>> fetchCoursesByTuteeId(
      http.Client client, int tuteeId) async {
    //wait for back end
    final response = await http.get('$COURSES_BY_TUTEEID_API/$tuteeId');
    //wait for back end
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    } else {
      throw Exception('Failed to fetch course by course id');
    }
  }

  //fetch all courses by tutee id and enrollment status
  Future<List<Course>> fetchCoursesByEnrollmentStatus(
      http.Client client, String status, int tuteeId) async {
    //host url
    String url = COURSES_BY_ENROLLMENT_STATUS_API;
    //query parameters
    Map<String, String> queryParams = {
      'tuteeId': tuteeId.toString(),
      'enrollmentStatus': status,
    };
    //transform to queryTring
    String queryString = Uri(queryParameters: queryParams).query;
    url += queryString;
    //merge to url

    final response = await http.get(url);
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    } else {
      throw Exception('Failed to fetch courses by filter');
    }
  }

  //post course
  Future postCourse(Course course) async {
    final http.Response response = await http.post(COURSE_API,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': course.id,
            'name': course.name,
            'beginTime': globals.defaultDatetime + 'T' + course.beginTime,
            'endTime': globals.defaultDatetime + 'T' + course.endTime,
            'studyForm': course.studyForm,
            'studyFee': course.studyFee,
            'daysInWeek': course.daysInWeek,
            'beginDate': course.beginDate,
            'endDate': course.endDate,
            'description': course.description,
            'classHasSubjectId': course.classHasSubjectId,
            'createdBy': course.createdBy,
            'status': course.status,
            'confirmedBy': course.confirmBy,
            'createdDate': course.createdDate,
            'confirmedDate': course.confirmedDate,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      return true;
    } else {
      print('this is: ' + response.body + response.statusCode.toString());
      print(response.statusCode);
      throw Exception('Faild to post Course');
    }
  }
}

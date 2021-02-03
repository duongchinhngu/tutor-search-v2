import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/course.dart';

class CourseRepository {
  //fetch all courses
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
  Future<List<Course>> fetchCoursesByTuteeId(http.Client client, int tuteeId) async {
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
}

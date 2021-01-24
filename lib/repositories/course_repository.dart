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
    }else{
      throw Exception('Failed to fetch all courses');
    }
  }
  //fetch courses by status
  Future<List<Course>> fetchCourseByFilter(http.Client client, String status) async {
    final response = await http.get('$SEARCH_COURSE_API$status');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((courses) => new Course.fromJson(courses))
          .toList();
    }else{
      throw Exception('Failed to fetch courses by status');
    }
  }
}
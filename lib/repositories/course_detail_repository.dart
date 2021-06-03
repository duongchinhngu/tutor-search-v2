import 'dart:convert';
import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:http/http.dart' as http;

class CourseDetailRepository {
  //insert new
  Future postCourseDetail(CourseDetail courseDetail, int courseId) async {
    final http.Response response = await http.post(COURSE_DETAIL_API,
        headers: await AuthorizationContants().getAuthorizeHeader(),
        body: jsonEncode(<String, dynamic>{
          'id': 0,
          'courseId': courseId,
          'period': courseDetail.period,
          'schedule': courseDetail.schedule,
          'learningOutcome': courseDetail.learningOutcome,
        }));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      return true;
    } else {
      print('this is: ' + response.body + response.statusCode.toString());
      print(response.statusCode);
      throw Exception('Fail to post CourseDetail');
    }
  }

  //update course
  Future putCourseDetail(CourseDetail courseDetail) async {
    final http.Response response =
        await http.put('$COURSE_DETAIL_API/${courseDetail.id}',
            headers: await AuthorizationContants().getAuthorizeHeader(),
            body: jsonEncode(<String, dynamic>{
              'id': courseDetail.id,
              'courseId': courseDetail.courseId,
              'period': courseDetail.period,
              'schedule': courseDetail.schedule,
              'learningOutcome': courseDetail.learningOutcome,
            }));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      return true;
    } else {
      print('this is: ' + response.body + response.statusCode.toString());
      print(response.statusCode);
      throw Exception('Fail to put CourseDetail');
    }
  }

  //get course detail by course id
  Future<List<CourseDetail>> fetchScheduleByCourseId(int courseId) async {
    final response = await http.get(
      '$COURSE_DETAIL_API/get-by-course/$courseId',
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((schedules) => new CourseDetail.fromJson(schedules))
          .toList();
    } else {
      print('this is error body: ' + response.body);
      throw Exception('Failed to fetch schdeule by course Id');
    }
  }

  //delete tutor update profile by id
  Future<bool> deleteCourseDetail(int courseId) async {
    final http.Response response = await http.delete(
      Uri.parse('$COURSE_DETAIL_API/delete-by-course/$courseId'),
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      print('Error body delte deleteCourseDetail: ' + response.body);
      return false;
    }
  }
}

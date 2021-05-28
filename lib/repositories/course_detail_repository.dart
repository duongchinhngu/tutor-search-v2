import 'dart:convert';

import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/coursse_detail.dart';
import 'package:http/http.dart' as http;

class CourseDetailRepository {
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
}

import 'dart:convert';

import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutor_report.dart';
import 'package:http/http.dart' as http;

class TutorReportRepository {
  //post TutorReport
  Future postTutorReport(TutorReport tutorReport) async {
    final http.Response response = await http.post(TUTOR_REPORT_API,
        headers: await AuthorizationContants().getAuthorizeHeader(),
        body: jsonEncode(
          <String, dynamic>{
            "description": tutorReport.description,
            "status": tutorReport.status,
            "id": 0,
            "reportTypeId": tutorReport.reportTypeId,
            "tutorId": tutorReport.tutorId,
            "image": tutorReport.image.toString(),
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      return true;
    } else {
      print('this is: ' + response.body + response.statusCode.toString());
      print(response.statusCode);
      throw Exception('Faild to post TutorReport');
    }
  }
}

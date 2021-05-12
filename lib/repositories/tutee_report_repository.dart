import 'dart:convert';

import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutee_report.dart';
import 'package:http/http.dart' as http;

class TuteeReportRepository {
  Future postTuteeReport(TuteeReport tuteeReport) async {
    final http.Response response = await http.post(TUTEE_REPORT_API,
        headers: await AuthorizationContants().getAuthorizeHeader(),
        body: jsonEncode(
          <String, dynamic>{
            "description": tuteeReport.description,
            "status": tuteeReport.status,
            "id": 0,
            "reportTypeId": tuteeReport.reportTypeId,
            "enrollmentId": tuteeReport.enrollmentId,
            "image": tuteeReport.image.toString(),
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      return true;
    } else {
      print('this is: ' + response.body + response.statusCode.toString());
      print(response.statusCode);
      throw Exception('Failed to post TutorReport');
    }
  }
}

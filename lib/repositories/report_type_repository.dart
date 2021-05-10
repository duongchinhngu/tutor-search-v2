import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/report_type.dart';

class ReportTypeRepository {
  //load report type by status and role id
  Future<List<ReportType>> fetchReportType(
      int roleId) async {
    final response = await http.get(
      '$REPORT_TYPE_API/get-by-role?roleId=$roleId',
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((reportTypes) => new ReportType.fromJson(reportTypes))
          .toList();
    } if (response.statusCode == 404) {
      return null;
    }else {
      print('this is error body: ' + response.body + response.statusCode.toString());
      throw Exception('Failed to fetch report types');
    }
  }
}
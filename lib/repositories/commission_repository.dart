import 'dart:convert';

import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/commission.dart';
import 'package:http/http.dart' as http;

class CommissionRepository {
  //get Fe json by Commission id
  Future<Commission> fetchCommissionByCommissionId(http.Client client, int id) async {
    final response = await http.get('$COMMISSION_API/$id', headers: await AuthorizationContants().getAuthorizeHeader(),);
    if (response.statusCode == 200) {
      return Commission.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch Commission by Commission id');
    }
  }
}
import 'dart:convert';

import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/fee.dart';
import 'package:http/http.dart' as http;

class FeeRepository {
  //get Fe json by fee id
  Future<Fee> fetchFeeByFeeId(http.Client client, int id) async {
    final response = await http.get('$FEE_API/$id');
    if (response.statusCode == 200) {
      return Fee.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch Fee by Fee id');
    }
  }
}
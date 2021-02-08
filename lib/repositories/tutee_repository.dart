import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutee.dart';

class TuteeRepository {
  //
   //fetch Tutee by Tutee id
  Future<Tutee> fetchTuteeByTuteeId(http.Client client, int id) async {
    final response = await http.get('$TUTEE_API/$id');
    if (response.statusCode == 200) {
      return Tutee.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to fetch Tutee by Tutee id');
    }
  }

  //fetch tutee by tutee email
  Future<Tutee> fetchTuteeByTuteeEmail(http.Client client, String email) async {
    final response = await http.get('$TUTEE_API/email/$email');
    if (response.statusCode == 200) {
      return Tutee.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to fetch Tutee by Tutee email: ' + response.statusCode.toString());
    }
  }
}
import 'dart:convert';

import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutor.dart';
import 'package:http/http.dart' as http;
class TutorRepository {
   //fetch tutor by tutor id
  Future<Tutor> fetchTutorByTutorId(http.Client client, int id) async {
    final response = await http.get('$TUTOR_API/$id');
    if (response.statusCode == 200) {
      return Tutor.fromJson(json.decode(response.body));
    }else{
      throw Exception('Failed to fetch Tutor by Tutor id');
    }
  }
}
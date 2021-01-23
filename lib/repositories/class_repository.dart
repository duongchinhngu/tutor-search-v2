import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/class.dart';

class ClassRepository {
  //fetch all class
  Future<List<Class>> fetchAllClass(http.Client client) async {
    final response = await http.get('$ALL_CLASS_API');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((classes) => new Class.fromJson(classes))
          .toList();
    }else{
      throw Exception('Failed to fetch all classes');
    }
  }
}

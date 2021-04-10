import 'dart:convert';

import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutor_transaction.dart';
import 'package:http/http.dart' as http;

class TutorTransactionRepository {
  //fetch
  Future<List<TutorTransaction>> fetchTutorTransactionByTutorId(
      http.Client client, int tutorId) async {
    final response = await http.get(
      '$TUTOR_TRANSACTION_API/tutor/$tutorId',
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((tutorTransaction) =>
              new TutorTransaction.fromJson(tutorTransaction))
          .toList();
    } else if (response.statusCode == 404) {
      return null;
    } else {
      print('this is error body: ' + response.body);
      throw Exception('Failed to fetch TutorTransactiones by tutorId');
    }
  }
}

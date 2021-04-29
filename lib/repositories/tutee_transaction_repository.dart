import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';

class TuteeTransactionRepository {
  //fetch classes by subject id
  Future<List<TuteeTransaction>> fetchTuteeTransactionByTuteeId(
      http.Client client, int tuteeId) async {
    final response = await http.get(
      '$TUTEE_TRANSACTION_API/tutee/$tuteeId',
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((tuteeTransactiones) =>
              new TuteeTransaction.fromJson(tuteeTransactiones))
          .toList();
    } else if (response.statusCode == 404) {
      return null;
    } else {
      print('this is error body: ' + response.body);
      throw Exception('Failed to fetch TuteeTransactiones by tuteeId');
    }
  }
}

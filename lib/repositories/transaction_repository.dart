import 'dart:convert';

import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/tutee_transaction.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/tutor_transaction.dart';

class TransactionRepository {
  //add new TuteeTransaction in DB when MoMO wallet transaction completed
  Future postTuteeTransaction(TuteeTransaction tuteeTransaction) async {
    final http.Response response = await http.post(TUTEE_TRANSACTION_API,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': tuteeTransaction.id,
            'dateTime': tuteeTransaction.dateTime,
            'amount': tuteeTransaction.amount,
            'totalAmount': tuteeTransaction.totalAmount,
            'description': tuteeTransaction.description,
            'status': tuteeTransaction.status,
            'tuteeId': tuteeTransaction.tuteeId,
            'feeId': tuteeTransaction.feeId,
            'feePrice': tuteeTransaction.feePrice,
            'tutorId': tuteeTransaction.tutorId,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Faild to post TuteeTransaction');
    }
  }

  //add new TuteeTransaction in DB when MoMO wallet transaction completed
  Future postTutorTransaction(TutorTransaction tutorTransaction) async {
    final http.Response response = await http.post(TUTOR_TRANSACTION_API,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': tutorTransaction.id,
            'dateTime': tutorTransaction.dateTime,
            'amount': tutorTransaction.amount,
            'totalAmount': tutorTransaction.totalAmount,
            'description': tutorTransaction.description,
            'status': tutorTransaction.status,
            'tutorId': tutorTransaction.tutorId,
            'feeId': tutorTransaction.feeId,
            'archievedPoints': tutorTransaction.archievedPoints,
            'usedPoints': tutorTransaction.usedPoints,
            'feePrice': tutorTransaction.feePrice,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print('error body tutor transaction: ' + response.body);
      print(response.statusCode);
      throw Exception('Faild to post TutorTransaction');
    }
  }
}

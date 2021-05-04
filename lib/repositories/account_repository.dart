import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/account.dart';

class AccountRepository {
  //load account by email
  Future<Account> fetchAccountByEmail(http.Client client, String email) async {
    final response = await http.get(
      '$ACCOUNT_API/email/$email',
    );
    if (response.statusCode == 200) {
      return Account.fromJson(json.decode(response.body));
    } else if (response.statusCode == 404) {
      return null;
    } else {
      throw Exception('Failed to fetch course by course id');
    }
  }

  //post account
  Future postAcount(Account account) async {
    final http.Response response = await http.post('$ACCOUNT_API',
        headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        },
        body: jsonEncode(
          <String, dynamic>{
            'email': account.email,
            'roleId': account.roleId,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print('error body account repo: ' + response.body);
      print(response.statusCode);
      throw Exception('Faild to post Account');
    }
  }

  //load account by email
  Future<String> isEmailExist(http.Client client, String email) async {
    final response = await http.get(
      '$ACCOUNT_API/check-email-exist/$email',
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      print('Error body check email account: ' + response.body);
      throw Exception('Failed to check email exist in Account table: ' +
          response.statusCode.toString());
    }
  }

  //post account
  Future resetFCMToken(String email, String token) async {
    final http.Response response = await http.put('$ACCOUNT_API/resetFcmToken',
        body: jsonEncode(
          <String, dynamic>{
            'email': email,
            'token': token,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print('error body account repo: ' + response.body);
      print(response.statusCode);
      throw Exception('Faild to put Account, reset fcm token');
    }
  }
}

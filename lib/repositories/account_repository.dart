import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/account.dart';

class AccountRepository {
  //load account by email; and then use RoleId to load Tutor or Tutee account info




  //load account by email
  Future<Account> fetchAccountByEmail(http.Client client, String email) async {
    final response = await http.get('$ACCOUNT_API/email/$email');
    if (response.statusCode == 200) {
      return Account.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch course by course id');
    }
  }
}

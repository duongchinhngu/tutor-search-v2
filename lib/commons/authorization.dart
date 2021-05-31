import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationContants {
  //get token from local storage
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  //return header with bearing token for all apis
  Future<Map<String, String>> getAuthorizeHeader() async {
    //
    String token;
    await getToken().then((value) {
      token = value;
    });
    //
    Map<String, String> authorizeHeader = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      'Content-Type': 'application/json; charset=UTF-8',
    };
    return authorizeHeader;
  }
}

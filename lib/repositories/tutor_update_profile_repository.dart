import 'dart:convert';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/tutor_update_profile.dart';

class TutorUpdateProfileRepository {
  //add new temporatory tutpr update profile
  Future postUpdateProfile(TutorUpdateProfile tutorUpdateProfile) async {
    final http.Response response = await http.post(TUTOR_UPDATE_PROFILE_API,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "id": tutorUpdateProfile.id,
            "fullname": tutorUpdateProfile.fullname,
            "gender": tutorUpdateProfile.gender,
            "birthday": tutorUpdateProfile.birthday,
            "phone": tutorUpdateProfile.phone,
            "avatarImageLink": tutorUpdateProfile.avatarImageLink,
            "address": tutorUpdateProfile.address,
            "educationLevel": tutorUpdateProfile.educationLevel,
            "school": tutorUpdateProfile.school,
            "socialIdUrl": tutorUpdateProfile.socialIdUrl,
            "certificateImages": tutorUpdateProfile.certificateImages,
            "email": tutorUpdateProfile.email,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print(response.statusCode.toString() + 'this is error body: ' + response.body);
      throw Exception('Faild to post TutorUpdateProfile');
    }
  }
}

import 'dart:convert';
import 'package:tutor_search_system/commons/authorization.dart';
import 'package:tutor_search_system/commons/urls.dart';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/models/tutor_update_profile.dart';

class TutorUpdateProfileRepository {
  //add new temporatory tutpr update profile
  Future postUpdateProfile(TutorUpdateProfile tutorUpdateProfile) async {
    final http.Response response = await http.post(TUTOR_UPDATE_PROFILE_API,
        headers: await AuthorizationContants().getAuthorizeHeader(),
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
            "description": tutorUpdateProfile.description,
            "confirmedDate": tutorUpdateProfile.confirmedDate,
            "points": tutorUpdateProfile.points,
            "membershipId": tutorUpdateProfile.membershipId,
            "roleId": tutorUpdateProfile.roleId,
            "status": tutorUpdateProfile.status,
            "createdDate": tutorUpdateProfile.createdDate,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print(response.statusCode.toString() +
          'this is error body: ' +
          response.body);
      throw Exception('Faild to post TutorUpdateProfile');
    }
  }

  //delete tutor update profile by id
  Future<bool> deleteTutorUpdateProfilebyId(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('$TUTOR_UPDATE_PROFILE_API/$id'),
      headers: await AuthorizationContants().getAuthorizeHeader(),
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      print('Error body delte tutor updat profile: ' + response.body);
      return false;
    }
  }
}

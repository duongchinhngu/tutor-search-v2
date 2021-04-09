import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/image.dart';

class ImageRepository {
  //add new TuteeTransaction in DB when MoMO wallet transaction completed
  Future postImage(Image image) async {
    final http.Response response = await http.post(IMAGE_API,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            'id': image.id,
            'imageLink': image.imageLink,
            'imageType': image.imageType,
            'ownerEmail': image.ownerEmail,
          },
        ));
    if (response.statusCode == 201 ||
        response.statusCode == 204 ||
        response.statusCode == 404) {
      print('this is: ' + response.body + response.statusCode.toString());
      return true;
    } else {
      print(response.statusCode);
      throw Exception('Faild to post postImage');
    }
  }

//get image by email
  Future<String> fetchImageByEmail(
      http.Client client, String email, String imageType) async {
        
    final response = await http
        .get('$IMAGE_API/get/result?ownerEmail=$email&imageType=$imageType');
         
    if (response.statusCode == 200) {
      String jsonResponse = json.decode(response.body).toString();
      print('Wer are here' + response.body);
      return jsonResponse.toString();
    } else if (response.statusCode == 404) {
      return null;
    } else {
      print('this is error body: ' + response.body);
      throw Exception('Failed to fetch Imagees by tutorId');
    }
  }
}

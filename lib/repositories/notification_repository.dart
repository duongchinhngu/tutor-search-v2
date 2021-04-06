import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tutor_search_system/commons/urls.dart';
import 'package:tutor_search_system/models/notification.dart';

class NotificationRepository {
  //fetch classes by subject id
  Future<List<Notification>> fetchNotificationByEmail(
      http.Client client, String email) async {
    final response = await http.get('$NOTIFICATION_API/email/$email');
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((notificationes) =>
              new Notification.fromJson(notificationes))
          .toList();
    } else if (response.statusCode == 404) {
      return null;
    } else {
      print('this is error body: ' + response.statusCode.toString());
      throw Exception('Failed to fetch Notificationes by emailId');
    }
  }
}

import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/chat/model/send_notification_model.dart';

class MessageService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static const String serverToken =
      'AAAAMmVYcZw:APA91bF5OTX58JeeEOEDuj4NIonZANQBmICM2ia6hyGUNLzCTcCv0CC4FoV8Di0c7qs-a8jokyVO4F5tcXlrGjSq77-KbV7vnyrhQxaHHoWXJYsTxD9TWE8klIQn6WjPKtbYzk_MUgqD';

  Future<String?> getFcmToken() async {
    return await messaging.getToken();
  }

  void sendNotification(SendNotificationModel notification) async {
    print("token = ${notification.fcmTokens}");
    http.Response response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode(notification.toMap()),
    );

    debugPrint("code: ----------- ${response.statusCode}");
    debugPrint("body: +++++++++++ ${response.body}");
  }
}

import 'dart:convert';


import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/chat/model/send_notification_model.dart';

class MessageService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  static const String serverToken =
      'AAAAAAcXNYE:APA91bF29Tc5rKfq6bQZ3EonQwS4m-JO75h3HRuhnMqsghYGOEypbgK2Kr2lk4OjzvyFP6lnWUIMBRmwnhBAca4pFqgnDM-JGNw7lrWNhsqwW0l69VeeHX-fuMqC6jZMTgBPn0GyICA0';

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

    print(response.statusCode);
    print(response.body);
  }
}

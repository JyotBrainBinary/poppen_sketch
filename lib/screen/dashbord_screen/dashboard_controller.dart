import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:sketch/chat/firebase_chat_manager.dart';
import 'package:sketch/chat/user_side_screen/chat_fire_screen.dart';
import 'package:sketch/screen/Favourites/favourites_screen.dart';
import 'package:sketch/screen/home_screen/home_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/pref_key.dart';

import '../../main.dart';

class DashBoardController extends GetxController {
  int selectedIndex = 0;
  final glbKey = GlobalKey();
  List<Widget> widgetOptions = [
    const HomeScreen(),
    const Text('Search'),
    FavouritesScreen(),
    PrefService.getString(PrefKeys.isManager) == "true"
        ? const ChatManager()
        : ChatFireScreen(
            isManager: false,
            roomId: PrefService.getString(PrefKeys.uid),
          ),
    GestureDetector(
        onTap: () {
          PrefService.clear();
        },
        child: const Text('Profile')),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update(["bottomBar"]);
  }

  //////////////  NOTIFICATION   /////////////

  @override
  void onInit() {
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });
    //
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channelDescription: channel.description,
    //             color: Colors.blue,
    //             playSound: true,
    //             icon: '@mipmap/ic_launcher',
    //           ),
    //         ));
    //   }
    // });

    super.onInit();
  }


}

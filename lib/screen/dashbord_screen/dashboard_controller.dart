import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/chat/firebase_chat_manager.dart';
import 'package:sketch/chat/user_side_screen/chat_fire_screen.dart';
import 'package:sketch/screen/Favourites/favourites_screen.dart';
import 'package:sketch/screen/Profile/profileScreen.dart';
import 'package:sketch/screen/home_screen/home_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/pref_key.dart';

class DashBoardController extends GetxController {
  int selectedIndex = 0;

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
    const Text('Profile'),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update(["bottomBar"]);
  }
}

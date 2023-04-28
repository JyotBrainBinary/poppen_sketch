import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/Favourites/favourites_screen.dart';
import 'package:sketch/screen/Profile/profileScreen.dart';
import 'package:sketch/screen/home_screen/home_screen.dart';

class DashBoardController extends GetxController {
  int selectedIndex = 0;

  List<Widget> widgetOptions =  [
    const HomeScreen(),
    const Text('Search'),
    FavouritesScreen(),
    const Text('Notification'),
      ProfileScreen(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update(["bottomBar"]);
  }
}

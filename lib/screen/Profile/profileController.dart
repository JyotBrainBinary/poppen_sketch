import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sketch/screen/Profile/widget/details_screen.dart';
import 'package:sketch/screen/Profile/widget/feed_screen.dart';
import 'package:sketch/screen/Profile/widget/reviews_screen.dart';
import 'package:sketch/utils/assets_res.dart';

class ProfileController extends GetxController{


  PageController pageController =PageController();

  int curr = 0;

  List<Widget> pageViewList = <Widget>[
    FeedScreen(),
    DetailScreen(),
    ReviewsScreen(),
  ];

  List feedImage = [
   AssetsRes.image1,
    AssetsRes.image2,
    AssetsRes.image3,
    AssetsRes.image4,
    AssetsRes.image5,
    AssetsRes.image6,
    AssetsRes.image1,
    AssetsRes.image2,
    AssetsRes.image3
  ];

  List weekList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List weekTimeList = [
    "5 - 10PM",
    "5 - 10PM",
    "5 - 10PM",
    "5 - 10PM",
    "5 - 12AM",
    "12 - 12AM",
    "12 - 10PM"
  ];

}
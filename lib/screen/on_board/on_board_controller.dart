import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardController extends GetxController {
  PageController? pageController;
  double currentPage = 0;

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    pageController!.addListener(() {
      currentPage = pageController!.page!;
      update(["onBoard"]);
    });
    update(["onBoard"]);
    super.onInit();
  }

  @override
  void dispose() {
    pageController!.dispose();
    update(["onBoard"]);
    super.dispose();
  }
}

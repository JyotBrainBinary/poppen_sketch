import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Favourites/favourites_screen.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/screen/home_screen/home_screen.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

Widget bottomNavigationBar(BuildContext context) {
  HomeController homeController  = Get.put(HomeController());
  return Container(
    width: Get.width,
    height: Get.height * 0.15,
    decoration: BoxDecoration(
      color: ColorRes.color161823,
      boxShadow: [
        BoxShadow(
          color: ColorRes.colorBlack.withOpacity(0.5),
          blurRadius: 9.0,
          spreadRadius: 0.13,
          // offset: const Offset(1.0, 5.5),
        )
      ],
    ),
    child: GetBuilder<HomeController>(
      id: "bottomBar",
        builder: (homeController){
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Row(

          children: [
            SizedBox(width: Get.width * 0.03),
            InkWell(
              onTap: (){
                homeController.index = 0;
                homeController.update(["bottomBar"]);
                Get.to(()=>HomeScreen());
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsRes.nearMe,
                    height: 20,
                    color: (homeController.index == 0) ? ColorRes.color7916F5 : ColorRes.colorBFBFBF,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    StringRes.nearMe,
                    style: regular(
                      color: (homeController.index == 0) ? ColorRes.colorWhite : ColorRes.colorBFBFBF,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.07),
            InkWell(
              onTap: (){
                homeController.index = 1;
                homeController.update(["bottomBar"]);
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsRes.places,
                    height: 20,
                    color: (homeController.index == 1) ? ColorRes.color7916F5 : ColorRes.colorBFBFBF,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    StringRes.places,
                    style: regular(
                      color: (homeController.index == 1) ? ColorRes.colorWhite : ColorRes.colorBFBFBF,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.06),
            InkWell(
              onTap: (){
                homeController.index = 2;
                homeController.update(["bottomBar"]);

                homeController.videoPlayerController.pause();
                Get.to(()=>FavouritesScreen());
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsRes.favourites,
                    height: 20,
                    color: (homeController.index == 2) ? ColorRes.color7916F5 : ColorRes.colorBFBFBF,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    StringRes.favourites,
                    style: regular(
                      color: (homeController.index == 2) ? ColorRes.colorWhite : ColorRes.colorBFBFBF,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.025),
            InkWell(
              onTap: (){
                homeController.index = 3;
                homeController.update(["bottomBar"]);
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsRes.notifications,
                    height: 20,
                    color: (homeController.index == 3) ? ColorRes.color7916F5 : ColorRes.colorBFBFBF,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    StringRes.notifications,
                    style: regular(
                      color: (homeController.index == 3) ? ColorRes.colorWhite : ColorRes.colorBFBFBF,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.05),
            InkWell(
              onTap: (){
                homeController.index = 4;
                homeController.update(["bottomBar"]);
              },
              child: Column(
                children: [
                  Image.asset(
                    AssetsRes.meIcon,
                    height: 20,
                    color: (homeController.index == 4) ? ColorRes.color7916F5 : ColorRes.colorBFBFBF,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    StringRes.me,
                    style: regular(
                      color: (homeController.index == 4) ? ColorRes.colorWhite : ColorRes.colorBFBFBF,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Get.width * 0.03),
          ],
        ),
      );
    })
  );
}

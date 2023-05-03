import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Favourites/favourites_screen.dart';
import 'package:sketch/screen/dashbord_screen/dashboard_controller.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/screen/home_screen/home_screen.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

Widget bottomNavigationBar(BuildContext context,
    ) {

  final controller = Get.find<DashBoardController>();
  return Container(
    key:   controller.glbKey,
    width: Get.width,
    height: Get.height * 0.11,
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
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          SizedBox(width: Get.width * 0.03),
          InkWell(
            onTap: () {
              controller.selectedIndex = 0;
              controller.update(["bottomBar"]);
              // Get.to(()=>HomeScreen());
            },
            child: Column(
              children: [
                Image.asset(
                  AssetsRes.nearMe,
                  height: 20,
                  color: (controller.selectedIndex == 0)
                      ? ColorRes.color7916F5
                      : ColorRes.colorBFBFBF,
                ),
                const SizedBox(height: 10),
                Text(
                  StringRes.nearMe,
                  style: regular(
                    color: (controller.selectedIndex == 0)
                        ? ColorRes.colorWhite
                        : ColorRes.colorBFBFBF,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.07),
          InkWell(
            onTap: () {
              controller.selectedIndex = 1;
              controller.update(["bottomBar"]);
            },
            child: Column(
              children: [
                Image.asset(
                  AssetsRes.places,
                  height: 20,
                  color: (controller.selectedIndex == 1)
                      ? ColorRes.color7916F5
                      : ColorRes.colorBFBFBF,
                ),
                const SizedBox(height: 10),
                Text(
                  StringRes.places,
                  style: regular(
                    color: (controller.selectedIndex == 1)
                        ? ColorRes.colorWhite
                        : ColorRes.colorBFBFBF,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.06),
          InkWell(
            onTap: () {
              controller.selectedIndex = 2;
              controller.update(["bottomBar"]);

              //homeController.videoPlayerController.pause();
              // Get.to(() => FavouritesScreen());
            },
            child: Column(
              children: [
                Image.asset(
                  AssetsRes.favourites,
                  height: 20,
                  color: (controller.selectedIndex == 2)
                      ? ColorRes.color7916F5
                      : ColorRes.colorBFBFBF,
                ),
                const SizedBox(height: 10),
                Text(
                  StringRes.favourites,
                  style: regular(
                    color: (controller.selectedIndex == 2)
                        ? ColorRes.colorWhite
                        : ColorRes.colorBFBFBF,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.025),
          InkWell(
            onTap: () {
              controller.selectedIndex = 3;
              controller.update(["bottomBar"]);
            },
            child: Column(
              children: [
                Image.asset(
                  AssetsRes.notifications,
                  height: 20,
                  color: (controller.selectedIndex == 3)
                      ? ColorRes.color7916F5
                      : ColorRes.colorBFBFBF,
                ),
                const SizedBox(height: 10),
                Text(
                  "    ${StringRes.chats}    ",
                  style: regular(
                    color: (controller.selectedIndex == 3)
                        ? ColorRes.colorWhite
                        : ColorRes.colorBFBFBF,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.05),
          InkWell(
            onTap: () {
              controller.selectedIndex = 4;
              controller.update(["bottomBar"]);
            },
            child: Column(
              children: [
                Image.asset(
                  AssetsRes.meIcon,
                  height: 20,
                  color: (controller.selectedIndex == 4)
                      ? ColorRes.color7916F5
                      : ColorRes.colorBFBFBF,
                ),
                const SizedBox(height: 10),
                Text(
                  " ${StringRes.me} ",
                  style: regular(
                    color: (controller.selectedIndex == 4)
                        ? ColorRes.colorWhite
                        : ColorRes.colorBFBFBF,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Get.width * 0.03),
        ],
      ),
    ),
  );
}

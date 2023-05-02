import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/screen/Profile/profileScreen.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:video_player/video_player.dart';

import '../../../common/widget/loaders.dart';
import 'home_bottom_area.dart';
import 'home_center_area.dart';
import 'home_center_area_image.dart';
import 'home_top_area.dart';

Widget onVideoUi(
    {required VideoPlayerController controller, required int index}) {
  final HomeController homeController = Get.find<HomeController>();

  double height = Get.height;
  double width = Get.width;
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Stack(
      children: [

        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Get.height * 0.13),

            /// ----------- top 1 ---------
            ///
            /// top area(appLogo and dropDown, search) - put in home screen in stack
           // HomeTopArea(),

            SizedBox(height: Get.height * 0.02),

            /// ----------- top 2 ------------
            HomeCenterArea(
              videoController: controller,
              index: index,
            ),

            const Spacer(),

            /// ----------- bottom -----------
            HomeBottomArea(index: index,),
            const SizedBox(height: 20),
          ],
        ),

        Obx(
          () => homeController.businessListModel.value.data == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.color8401FF,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.04),

                    /// ----------- top 1 ---------
                    //HomeTopArea(),

                    SizedBox(height: Get.height * 0.02),

                    /// ----------- top 2 ------------
                    HomeCenterArea(
                      videoController: controller,
                      index: index,
                    ),

                    const Spacer(),

                    /// ----------- bottom -----------
                    HomeBottomArea(
                      index: index,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
        ),
        Obx(() => homeController.isDrop.value == true
            ? Column(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 180,
                      padding: const EdgeInsets.all(0),
                      margin: EdgeInsets.only(top: height * 0.07),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20),
                        // border: Border.all(
                        //     color: Colors.transparent.withOpacity(0.6)),
                      ),
                      child: ListView.builder(
                        itemCount:
                            homeController.intrestListData.value.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item =
                              homeController.intrestListData.value.data![index];
                          return GestureDetector(
                            onTap: () {
                              homeController.dropItemTap(
                                  name: item.name.toString(),
                                  category: item.id.toString().padLeft(2, '0'));
                            },
                            child: Container(
                              height: Get.height * 0.04,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: ColorRes.color161823.withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: Get.height * 0.02,
                                    width: Get.width * 0.035,
                                    color: ColorRes.color8401FF,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    item.name.toString(),
                                    style: regular(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox()),
        Obx(() => homeController.isLoading.value ||
                homeController.businessListModel.value.data!.isEmpty
            ? Container(
                width: width,
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.color8401FF,
                  ),
                ),
              )
            : const SizedBox())
      ],
    ),
  );
}

Widget onImageUi({required int index}) {
  final HomeController homeController = Get.find<HomeController>();

  double height = Get.height;
  double width = Get.width;
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Stack(
      children: [
        Obx(
          () => homeController.businessListModel.value.data == null
              ? const Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.color8401FF,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: Get.height * 0.03),

                    /// ----------- top 1 ---------
                    HomeTopArea(),

                    SizedBox(height: Get.height * 0.02),

                    /// ----------- top 2 ------------
                    HomeCenterAreaImage(
                        // videoController: controller,
                        index: index),

                    const Spacer(),

                    /// ----------- bottom -----------
                    HomeBottomArea(
                      index: index,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
        ),
        Obx(() => homeController.isDrop.value == true
            ? Column(
                children: [
                  Center(
                    child: Container(
                      height: 100,
                      width: 180,
                      padding: const EdgeInsets.all(0),
                      margin: EdgeInsets.only(top: height * 0.07),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.8),
                        borderRadius: BorderRadius.circular(20),
                        // border: Border.all(
                        //     color: Colors.transparent.withOpacity(0.6)),
                      ),
                      child: ListView.builder(
                        itemCount:
                            homeController.intrestListData.value.data!.length,
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item =
                              homeController.intrestListData.value.data![index];
                          return GestureDetector(
                            onTap: () {
                              homeController.dropItemTap(
                                  name: item.name.toString(),
                                  category: item.id.toString().padLeft(2, '0'));
                            },
                            child: Container(
                              height: Get.height * 0.04,
                              alignment: Alignment.center,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                // color: ColorRes.color161823.withOpacity(0.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: Get.height * 0.02,
                                    width: Get.width * 0.035,
                                    color: ColorRes.color8401FF,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    item.name.toString(),
                                    style: regular(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox()),
        Obx(() => homeController.isLoading.value ||
                homeController.businessListModel.value.data!.isEmpty
            ? Container(
                width: width,
                color: Colors.black,
                child: Center(
                  child: CircularProgressIndicator(
                    color: ColorRes.color8401FF,
                  ),
                ),
              )
            : const SizedBox())
      ],
    ),
  );
}


///static data

/*
Widget onImageUi(
    { required int index}) {
  final HomeController homeController = Get.find<HomeController>();

  double height = Get.height;
  double width = Get.width;
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Get.height * 0.03),

        /// ----------- top 1 ---------
        HomeTopArea(),

        SizedBox(height: Get.height * 0.02),

        /// ----------- top 2 ------------
        HomeCenterAreaImage(
          //videoController: controller,
            index: index
        ),

        const Spacer(),

        /// ----------- bottom -----------
        HomeBottomArea(index: index,),
        const SizedBox(height: 20),
      ],
    ),
  );
}*/

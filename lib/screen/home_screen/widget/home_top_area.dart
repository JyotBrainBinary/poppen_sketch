import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/screen/on_board/on_board_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class HomeTopArea extends StatelessWidget {
  HomeTopArea({
    super.key,
  });

  final HomeController homeController = Get.find<HomeController>();




  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      id: "id",
      builder: (controller) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: Get.width*0.03),
          child: Column(
            children: [
              SizedBox(height: Get.height*0.035,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () async {
                      PrefService.clear();
                      Get.offAll(OnBoardScreen());
                    },
                    child: Image.asset(
                      AssetsRes.appLogo,
                      width: Get.width*0.05,
                    ),
                  ),


                  homeController.intrestListData.value.data == null
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () {
                            homeController.dropOnTap();
                          },
                          child: Container(
                            height: Get.height * 0.04,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: ColorRes.color161823.withOpacity(0.3),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AssetsRes.message,
                                  height: Get.height * 0.02,
                                  width: Get.height * 0.02,
                                  fit: BoxFit.cover,
                                  color: Colors.white,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  homeController.selectedIntrestValue,
                                  style: regular(fontSize: 12),
                                ),
                                const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: ColorRes.colorWhite,
                                  size: 20,
                                )
                              ],
                            ),
                          ),
                        ),
                  GestureDetector(
                    onTap: () async {
                      // PrefService.clear();
                      // Get.offAll(OnBoardScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Image.asset(
                        AssetsRes.search,
                        width: Get.width*0.05,
                      ),
                    ),
                  ),
                ],
              ),

              ///---> show Drop Down
            ],
          ),
        );
      },
    );
  }
}

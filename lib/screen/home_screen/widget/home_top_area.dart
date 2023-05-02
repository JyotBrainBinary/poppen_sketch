import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/screen/auth/create_account/what_intrested/what_intrested_controller.dart';
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
        return Column(
          children: [
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

               /// static data

               /* GestureDetector(
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
                          "dropDown",
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
                ),*/


               ///api data
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
                const SizedBox(
                  height: 20,
                  width: 20,
                  // child: Container(
                  //   decoration: BoxDecoration(
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: ColorRes.colorBlack.withOpacity(0.2),
                  //           blurRadius: 13.0,
                  //           spreadRadius: 0.01,
                  //           // offset: const Offset(1.0, 5.5),
                  //         )
                  //       ],
                  //       image: DecorationImage(
                  //         image: AssetImage(AssetsRes.search),
                  //         scale: 4.5,
                  //       )),
                  // ),
                ),
              ],
            ),

            ///---> show Drop Down
          ],
        );
      },
    );
  }
}

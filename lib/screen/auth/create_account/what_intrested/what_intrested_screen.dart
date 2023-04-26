import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/screen/auth/create_account/what_intrested/what_intrested_controller.dart';
import 'package:sketch/screen/auth/login/login_screen.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

class WhatIntrestedScreen extends StatelessWidget {
  WhatIntrestedScreen({Key? key}) : super(key: key);
  final WhatIntrestedController controller = Get.put(WhatIntrestedController());
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: ColorRes.colorWhite,
      body: Stack(
        children:[
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: GetBuilder<WhatIntrestedController>(
                id: "id",
                builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTopAuthScreen(
                        height: height,
                        width: width,
                        title: StringRes.whatIntrested,
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      GridView.builder(
                        shrinkWrap: true,
                        itemCount: controller.intrestedList.length,
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: width * 0.012,
                            childAspectRatio: 2.5),
                        itemBuilder: (context, index) {
                          final item = controller.intrestedList[index];
                          return GestureDetector(
                            onTap: () {
                              controller.selectCategory(item: item);
                            },
                            child: Container(
                              padding:
                              EdgeInsets.symmetric(horizontal: width * 0.025),
                              decoration: BoxDecoration(
                                color: controller.selectedIntrestList.contains(item)
                                    ? ColorRes.colorBlack
                                    : Colors.transparent,
                                border: Border.all(
                                    color:  controller.selectedIntrestList.contains(item)
                                        ? Colors.transparent
                                        : ColorRes.colorEBEBEB, width: 1),
                                borderRadius: BorderRadius.circular(26),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: width * 0.04,
                                    width: width * 0.04,
                                    color: item == "Restaurants"
                                        ? ColorRes.color8401FF
                                        : item == "Bars"
                                        ? Colors.red
                                        : ColorRes.colorBlack,
                                  ),
                                  SizedBox(
                                    width: width * 0.015,
                                  ),
                                  Text(
                                    controller.intrestedList[index],
                                    style: TextStyle(
                                        color: controller.selectedIntrestList
                                            .contains(item)
                                            ? ColorRes.colorWhite
                                            : ColorRes.colorBlack,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CommonButton(
                        height: height,
                        width: width,
                        color: ColorRes.color8401FF,
                        text: StringRes.startDiscovering,
                        isRightArrow: true,
                        onTap: () {
                          controller.validateIntrest();

                        },
                      ),
                      Spacer(),
                      SizedBox(
                        height: height * 0.05,
                      ),
                      CommonCreateAccText(
                        text1: StringRes.doNotHaveAc,
                        text2: StringRes.createOne,
                        onTap: () {},
                      ),
                      SizedBox(
                        height: height * 0.055,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          Obx(() => controller.loading.value
              ? const Center(
            child: FullScreenLoader(enableBgColor: true),
          )
              : const SizedBox())
        ],

      ),
    );
  }
}

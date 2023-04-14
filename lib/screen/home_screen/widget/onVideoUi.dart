import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

Widget onVideoUi(){
  HomeController homeController = Get.put(HomeController());
  return Padding(
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: Get.height * 0.085),

        /// ----------- top 1 ---------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: Get.height * 0.03,
              width: Get.width * 0.05,
              color: ColorRes.color7916F5,
            ),
            Container(
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
                  Container(
                    height: Get.height * 0.02,
                    width: Get.width * 0.035,
                    color: ColorRes.colorWhite,
                  ),
                  const SizedBox(width: 10,),
                  Text("Restaurant", style: regular(fontSize: 12),),
                  Icon(Icons.keyboard_arrow_down_rounded, color: ColorRes.colorWhite, size: 20,)
                ],
              ),
            ),
            SizedBox(
              height: 20,
              width: 20,
              child:  Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: ColorRes.colorBlack.withOpacity(0.2),
                        blurRadius: 13.0,
                        spreadRadius: 0.01,
                        // offset: const Offset(1.0, 5.5),
                      )
                    ],
                    image: DecorationImage(
                      image: AssetImage(AssetsRes.search),
                      scale: 4.5,
                    )
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: Get.height * 0.06),

        /// ----------- top 2 ------------
        Image.asset(AssetsRes.restaurantLogo, height: Get.height * 0.1,),
        const SizedBox(height: 5),
        Container(
          height: Get.height * 0.045,
          width: Get.width * 0.4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: ColorRes.colorWhite,
            boxShadow: [
              BoxShadow(
                color: ColorRes.colorBlack.withOpacity(0.2),
                blurRadius: 13.0,
                spreadRadius: 0.13,
                // offset: const Offset(1.0, 5.5),
              )
            ],
          ),
          child: Text("Republiq Bar & Grill", style: regular(color: ColorRes.colorBlack),),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
                  Container(
                    height: Get.height * 0.02,
                    width: Get.width * 0.035,
                    color: ColorRes.color4A48F1,
                  ),
                  const SizedBox(width: 10,),
                  Text("Restaurant", style: regular(fontSize: 12),),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Container(
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
                  Container(
                    height: Get.height * 0.02,
                    width: Get.width * 0.035,
                    color: ColorRes.colorEA4258,
                  ),
                  const SizedBox(width: 10,),
                  Text("Date Night", style: regular(fontSize: 12),),
                ],
              ),
            ),
            const SizedBox(width: 5),
            Container(
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
                  Container(
                    height: Get.height * 0.02,
                    width: Get.width * 0.035,
                    color: ColorRes.colorWhite,
                  ),
                  const SizedBox(width: 10,),
                  Text("Bar", style: regular(fontSize: 12),),
                ],
              ),
            ),
          ],
        ),

        const Spacer(),

        /// ----------- bottom -----------
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ///visit
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ImageStack(
                      imageList: homeController.visitsPeopleImage
                          .map((e) => e.toString())
                          .toList(),
                      totalCount: 3,
                      // If larger than images.length, will show extra empty circle
                      imageRadius: 32,
                      // Radius of each images
                      imageCount: 3,
                      // Maximum number of images to be shown in stack
                      imageBorderWidth: 0,

                      showTotalCount: false,
                      // Border width around the images
                    ),
                    const SizedBox(width: 5),
                    Text("+6k Visits", style: regularShaow())
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      height: Get.height * 0.03,
                      width: Get.width * 0.22,
                      color: ColorRes.colorEFC744,
                      child: Row(
                        children: List.generate(4, (index) => Row(
                          children: [
                            Container(
                              width: 1,
                              height: 20,
                              color: Colors.grey,
                            ),
                            SizedBox(width: Get.width * 0.05,)
                          ],
                        ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text("(55)", style: regularShaow())
                  ],
                ),
              ],
            ),

            ///3 icon
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                      ),
                      child:  Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorRes.colorBlack.withOpacity(0.2),
                                blurRadius: 13.0,
                                spreadRadius: 0.01,
                                // offset: const Offset(1.0, 5.5),
                              )
                            ],
                            image: DecorationImage(
                              image: AssetImage(AssetsRes.message),
                              scale: 4.5,
                            )
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text("1.5k", style: regularShaow(),),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                      ),
                      child:  Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorRes.colorBlack.withOpacity(0.2),
                                blurRadius: 13.0,
                                spreadRadius: 0.01,
                                // offset: const Offset(1.0, 5.5),
                              )
                            ],
                            image: DecorationImage(
                              image: AssetImage(AssetsRes.share),
                              scale: 4.5,
                            )
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text("SHARE", style: regularShaow(),),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                      ),
                      child:  Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: ColorRes.colorBlack.withOpacity(0.2),
                                blurRadius: 13.0,
                                // offset: const Offset(1.0, 5.5),
                              )
                            ],
                            image: DecorationImage(
                              image: AssetImage(AssetsRes.star),
                              scale: 4.5,
                            )
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text("250", style: regularShaow(),),
                  ],
                ),

              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    ),
  );
}
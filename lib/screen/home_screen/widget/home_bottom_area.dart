import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:sketch/api_call/favourite_api_call.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class HomeBottomArea extends StatelessWidget {
  HomeBottomArea({
    super.key,
    required this.index,
  });
  final int index;

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    RxBool isFav =
        homeController.businessListModel.value.data![index].isFavourite!.obs;
    RxInt favCount =
        homeController.businessListModel.value.data![index].favouriteCount!.obs;

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              // color: Colors.amber,
              colors: [
            Colors.transparent,
            Colors.black.withOpacity(.45),
          ],
              // ColorRes.colorBlack.withOpacity(.35),
              stops: [
            0,
            2
          ],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated)),
      child: Padding(
        padding: EdgeInsets.only(bottom: 15, top: Get.height * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ///api data
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.location_pin,
                  color: Colors.white,
                  weight: Get.width * 0.05,
                ),
                SizedBox(width: Get.width * 0.01),
                SizedBox(
                  width: Get.width * 0.32,
                  child: Text(
                    homeController.businessListModel.value.data![index].address!
                        .split(",")
                        .last
                        .toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: ColorRes.colorWhite,
                        height: 2.7,
                        fontSize: 13,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),

            ///3 icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 10),

                ///api data
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 42,
                      width: 42,
                      padding: EdgeInsets.all(Get.width * 0.015),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                            color: ColorRes.colorWhite.withOpacity(0.8)),
                        boxShadow: [
                          BoxShadow(
                            color: ColorRes.colorBlack.withOpacity(0.2),
                            blurRadius: 13.0,
                            spreadRadius: 0.01,
                            // offset: const Offset(1.0, 5.5),
                          )
                        ],
                      ),
                      child: Center(
                          child: Image.asset(
                        AssetsRes.share,
                        color: ColorRes.colorWhite,
                      )),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "SHARE",
                      style: regularShaow(
                          fontSize: 12,
                          color: ColorRes.colorWhite,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(width: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () {
                        return GestureDetector(
                          onTap: () {
                            print("-----------${isFav.value}");
                            isFav.value == false
                                ? FavouriteApi.addFavourite(
                                    id: homeController
                                        .businessListModel.value.data![index].id
                                        .toString(),
                                  )
                                : FavouriteApi.removeFavourite(
                                    id: homeController
                                        .businessListModel.value.data![index].id
                                        .toString(),
                                  );
                            isFav.value ? favCount.value-- : favCount.value++;
                            isFav.value = !isFav.value;
                            homeController.businessListModel.value.data![index]
                                .isFavourite = isFav.value;
                            homeController.businessListModel.value.data![index]
                                .favouriteCount = favCount.value;
                            print("+++++++++++${isFav.value}");
                            print("+++++++++++${favCount.value}");
                          },
                          child: Container(
                            height: 42,
                            width: 42,
                            padding: EdgeInsets.all(Get.width * 0.015),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                  color: isFav.value == true
                                      ? ColorRes.colorEFC744
                                      : ColorRes.colorWhite.withOpacity(0.8)),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: ColorRes.colorBlack.withOpacity(0.2),
                              //     blurRadius: 13.0,
                              //     spreadRadius: 0.01,
                              //     // offset: const Offset(1.0, 5.5),
                              //   )
                              // ],
                            ),
                            child: Center(
                              child: Image.asset(
                                AssetsRes.star,
                                color: isFav.value == true
                                    ? ColorRes.colorEFC744
                                    : ColorRes.colorWhite,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    Obx(
                      () => Text(
                        favCount.value.toString(),
                        style: regularShaow(
                            fontSize: 12,
                            color: ColorRes.colorWhite,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void handleFavourite() {}
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Favourites/favourites_controller.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class FavouriteBox extends StatelessWidget {
  FavouriteBox({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final controller = Get.find<FavouritesController>();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.favouriteList.length,
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      separatorBuilder: (context, index) {
        return SizedBox(
          height: height * 0.035,
        );
      },
      itemBuilder: (context, index) {
        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: width * 0.025, vertical: height * 0.012),
                height: Get.height * 0.25,
                width: Get.width,
                decoration: BoxDecoration(
                  border: Border.all(color: ColorRes.colorE9E9E9),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        // margin: const EdgeInsets.only(top: 7, right: 7),
                        height: 20,
                        width: 20,
                        color: ColorRes.colorEFC744,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(AssetsRes.restaurantLogo, height: 50),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Column(
                          children: [
                            Text(
                              "Republiq Bar & Grill",
                              style: regular(
                                  color: ColorRes.color161823,
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  AssetsRes.location,
                                  width: width * 0.04,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  "Brighton-Le-Sands",
                                  style: regular(
                                      color: ColorRes.color161823,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: height * 0.053,
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount:
                            controller.favouriteList[index]["dataList"].length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: width * 0.01,
                          );
                        },
                        itemBuilder: (context, index2) {
                          var data = controller.favouriteList[index]["dataList"]
                              [index2];
                          return Container(
                            // width: width * 0.25,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03,
                                vertical: height * 0.01),
                            decoration: BoxDecoration(
                                color: ColorRes.color161823,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  data["image"],
                                  width: width * 0.053,
                                ),
                                SizedBox(
                                  width: width * 0.02,
                                ),
                                Text(
                                  data["text"],
                                  style: const TextStyle(
                                      color: ColorRes.colorWhite, fontSize: 12),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Row(
                children: [
                  _buildButtonBox(
                      image: AssetsRes.direction,
                      text: StringRes.directions,
                      ontap: () {}),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  _buildButtonBox(
                      image: AssetsRes.message,
                      text: StringRes.message,
                      ontap: () {}),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  _buildButtonBox(text: StringRes.bookNow, ontap: () {}),
                ],
              ),
              index == controller.favouriteList.length - 1
                  ? SizedBox(
                      height: height * 0.035,
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildButtonBox(
      {String? image, required String text, required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: (width * 0.9) / 3,
        height: height * 0.07,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        decoration: const BoxDecoration(
          color: ColorRes.colorE9E9E9,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            image != null
                ? Image.asset(
                    image,
                    width: width * 0.05,
                    color: Colors.black,
                  )
                : const SizedBox(),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),
            image != null
                ? const SizedBox()
                : const SizedBox(
                    width: 4,
                  ),
          ],
        ),
      ),
    );
  }
}

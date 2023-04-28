import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/common_small_button.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  double height = Get.height;
  double width = Get.width;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height * 0.025,
              ),
              Image.asset(AssetsRes.restaurantLogo, height: height * 0.15),
              SizedBox(
                height: Get.height * 0.015,
              ),
              Text(
                "Republiq Bar & Grill",
                style: regular(
                    fontSize: 17,
                    color: ColorRes.color161823,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                "WWW.RQREPUBLIQ.COM.AU",
                style: regular(
                    color: ColorRes.color7F0E1A,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
              SizedBox(
                height: Get.height * 0.025,
              ),
              Text(
                "🍽 Middle Eastern and Mediterranean Cuisine",
                style: regular(fontSize: 12, color: ColorRes.color6C6C6C),
              ),
              Text(
                "🍸 World Class Bar",
                style: regular(fontSize: 12, color: ColorRes.color6C6C6C),
              ),
              Text(
                "📍 Heart of Brighton-Le-Sands",
                style: regular(fontSize: 12, color: ColorRes.color6C6C6C),
              ),

              /// ---------- containers ------

              SizedBox(height: Get.height * 0.03),
              SizedBox(
                height: height * 0.043,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount:
                      3 /*item.category
                      .toString()
                      .split(",")
                      .toList()
                      .length*/
                  ,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: width * 0.01,
                    );
                  },
                  itemBuilder: (context, index2) {
                    // var data = item.category
                    //     .toString()
                    //     .split(",")
                    //     .toList()[index2];

                    return Container(
                      // width: width * 0.25,
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03, vertical: height * 0.005),
                      decoration: BoxDecoration(
                          color: ColorRes.color161823,
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetsRes.message,
                            width: width * 0.053,
                          ),
                          SizedBox(
                            width: width * 0.02,
                          ),
                          const Text(
                            "data",
                            style: TextStyle(
                                color: ColorRes.colorWhite,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              SizedBox(height: Get.height * 0.03),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: Row(
                  children: [
                    CommonSmallButton(
                      image: AssetsRes.direction,
                      ontap: () {},
                      text: StringRes.directions,
                    ),
                    SizedBox(
                      width: width * 0.015,
                    ),
                    CommonSmallButton(
                      image: AssetsRes.message,
                      ontap: () {},
                      text: StringRes.message,
                    ),
                    // SizedBox(
                    //   width: width * 0.01,
                    // ),
                    // _buildButtonBox(text: StringRes.bookNow, ontap: () {}),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.03),

              /// ------ Post --------------
              post(),
            ],
          ),
        ),
      ),
    );
  }

  Widget post() {
    ProfileController profileController = Get.put(ProfileController());
    return GetBuilder<ProfileController>(
        id: "tab",
        builder: (profileController) {
          return Column(
            children: [
              const Divider(
                thickness: 1,
                color: ColorRes.colorD5D6D7,
              ),

              /// ---------- tabs ------------

              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      profileController.curr = 0;
                      profileController.pageController.jumpToPage(0);
                      profileController.update(["tab"]);
                    },
                    child: Container(
                      width: Get.width / 3,
                      alignment: Alignment.center,
                      child: Image.asset(AssetsRes.feedIcon,
                          height: 30,
                          color: (profileController.curr != 0)
                              ? ColorRes.colorD7D7D9
                              : ColorRes.color161823),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      profileController.curr = 1;
                      profileController.pageController.jumpToPage(1);
                      profileController.update(["tab"]);
                    },
                    child: Container(
                      width: Get.width / 3,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (profileController.curr != 1)
                                  ? ColorRes.colorD7D7D9
                                  : ColorRes.color161823,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            StringRes.details,
                            style: medium(
                                color: (profileController.curr != 1)
                                    ? ColorRes.colorD7D7D9
                                    : ColorRes.color161823),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      profileController.curr = 2;
                      profileController.pageController.jumpToPage(2);
                      profileController.update(["tab"]);
                    },
                    child: Container(
                      width: Get.width / 3,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AssetsRes.favourites,
                              height: 20,
                              color: (profileController.curr != 2)
                                  ? ColorRes.colorD7D7D9
                                  : ColorRes.colorEFC744),
                          const SizedBox(width: 10),
                          Text(
                            StringRes.reviews,
                            style: medium(
                                color: (profileController.curr != 2)
                                    ? ColorRes.colorD7D7D9
                                    : ColorRes.color161823),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                alignment: (profileController.curr == 2)
                    ? Alignment.centerRight
                    : (profileController.curr == 1)
                        ? Alignment.center
                        : Alignment.centerLeft,
                children: [
                  Container(
                    height: 1,
                    color: ColorRes.colorD5D6D7,
                  ),
                  Container(
                    height: 2.3,
                    width: Get.width * 0.3,
                    color: ColorRes.color161823,
                  ),
                ],
              ),

              /// ----- pageView ---------------
              SizedBox(
                height: Get.height * 0.6,
                child: PageView(
                  children: profileController.pageViewList,
                  scrollDirection: Axis.horizontal,
                  // reverse: true,
                  physics: BouncingScrollPhysics(),
                  controller: profileController.pageController,

                  onPageChanged: (num) {
                    profileController.curr = num;
                    profileController.update(["tab"]);
                  },
                ),
              ),
            ],
          );
        });
  }
}



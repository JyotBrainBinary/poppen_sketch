import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/common_appbar.dart';
import 'package:sketch/common/widget/common_small_button.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/screen/Profile/widget/details_screen.dart';
import 'package:sketch/screen/Profile/widget/feed_screen.dart';
import 'package:sketch/screen/dashbord_screen/dashboard_controller.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  double height = Get.height;
  double width = Get.width;
  final ProfileController controller = Get.put(ProfileController());
  final dashBoardController = Get.find<DashBoardController>();
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    // var item;
    // if (controller.viewBusinessModel.value.status == true) {
    //   item = controller.viewBusinessModel.value.data;
    //   controller.update(["id"]);
    // }
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProfileController>(
          id: "id",
          builder: (controller) {
            return controller.viewBusinessModel.value.status ==
                    true /*&& item != null*/
                ? Column(
                    children: [
                      CommonAppBar(
                        index: 4,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.025,
                              ),
                              GestureDetector(
                                onTap: () {
                                  // PrefService.clear();
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(99),
                                  child: Image.network(
                                    controller
                                        .viewBusinessModel.value.data!.logoUrl
                                        .toString(),
                                    height: height * 0.15,
                                    width: height * 0.15,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Image.asset(
                                        AssetsRes.restaurantLogo,
                                        height: height * 0.15,
                                        width: height * 0.15,
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.asset(
                                        AssetsRes.restaurantLogo,
                                        height: height * 0.15,
                                        width: height * 0.15,
                                        fit: BoxFit.cover,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: Get.height * 0.015,
                              ),
                              Text(
                                controller.viewBusinessModel.value.data!.name
                                    .toString(),
                                style: regular(
                                    fontSize: 17,
                                    color: ColorRes.color161823,
                                    fontWeight: FontWeight.w400),
                              ),
                              Text(
                                controller.viewBusinessModel.value.data!.website
                                    .toString(),
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
                                style: regular(
                                    fontSize: 12, color: ColorRes.color6C6C6C),
                              ),
                              Text(
                                "🍸 World Class Bar",
                                style: regular(
                                    fontSize: 12, color: ColorRes.color6C6C6C),
                              ),
                              Text(
                                "📍 Heart of Brighton-Le-Sands",
                                style: regular(
                                    fontSize: 12, color: ColorRes.color6C6C6C),
                              ),

                              /// ---------- containers ------

                              SizedBox(height: Get.height * 0.03),
                              SizedBox(
                                height: height * 0.043,
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  itemCount: controller
                                      .viewBusinessModel.value.data!.category
                                      .toString()
                                      .split(",")
                                      .toList()
                                      .length,
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: width * 0.01,
                                    );
                                  },
                                  itemBuilder: (context, index2) {
                                    var data = controller
                                        .viewBusinessModel.value.data!.category
                                        .toString()
                                        .split(",")
                                        .toList()[index2];
                                    return Container(
                                      // width: width * 0.25,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: width * 0.03,
                                          vertical: height * 0.005),
                                      decoration: BoxDecoration(
                                          color: ColorRes.color161823,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            AssetsRes.message,
                                            width: width * 0.053,
                                          ),
                                          SizedBox(
                                            width: width * 0.02,
                                          ),
                                          Text(
                                            homeController.categoryNameList[
                                                int.parse(data) - 1],
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.04),
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
                                      ontap: () {
                                        // print("object");
                                        // dashBoardController.onItemTapped(3);
                                        // dashBoardController.update(["bottomBar"]);
                                        // controller.update(["id"]);
                                      },
                                      text: StringRes.message,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: Get.height * 0.02),

                              /// ------ Post --------------
                              post(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : controller.viewBusinessModel.value.data.toString() ==
                        "Not yet any business"
                    ? const SizedBox(
                        child: Center(child: Text("No data found")),
                      )
                    : const Center(
                        child: CircularProgressIndicator(
                          color: ColorRes.color8401FF,
                        ),
                      );
          },
        ),
      ),
    );
  }

  Widget post() {
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
                  _buildTab(
                      onTap: () {
                        print("-------- ${profileController.isGalleryTab}");
                        profileController.changeTab();
                      },
                      icon: AssetsRes.feedIcon,
                      isGallery: !profileController.isGalleryTab,
                      isText: false,
                    text: "",
                  ),
                  _buildTab(
                      onTap: () {
                        profileController.changeTab();
                      },
                      icon: AssetsRes.info,
                      isGallery: profileController.isGalleryTab,
                      isText: true,
                  text: StringRes.details),
                ],
              ),
              const SizedBox(height: 5),
              Stack(
                alignment: profileController.isGalleryTab
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                children: [
                  Container(
                    height: 1,
                    color: ColorRes.colorD5D6D7,
                  ),
                  Container(
                    height: 2.3,
                    width: Get.width * 0.5,
                    color: ColorRes.color161823,
                  ),
                ],
              ),

              /// ----- pageView ---------------
              SizedBox(
                // height: Get.height * 0.6,
                child: profileController.isGalleryTab
                    ? FeedScreen()
                    : const DetailScreen(),
              ),
            ],
          );
        });
  }

  Widget _buildTab(
      {required VoidCallback onTap,
      String? text,
      required String icon,
      required bool isText,
      required bool isGallery}) {
    return GestureDetector(
      onTap: onTap,
      // profileController.curr = 0;
      // profileController.pageController.jumpToPage(0);
      // profileController.update(["tab"]);

      child: Container(
        width: Get.width / 2,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: Row(
          children: [
            Image.asset(icon,
                height: Get.height * 0.035,
                width: Get.height * 0.035,
                // fit: BoxFit.cover,
                color: isGallery ? ColorRes.colorD7D7D9 : ColorRes.color161823),
            Text(
              StringRes.details,
              style: TextStyle(color: ColorRes.colorD8D8D8, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/on_board/on_board_controller.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';

import 'package:sketch/utils/color_res.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardScreen extends StatelessWidget {
  OnBoardScreen({Key? key}) : super(key: key);
  final controller = Get.put(OnBoardController());

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: ColorRes.colorWhite,
      body: GetBuilder<OnBoardController>(
        id: "onBoard",
        builder: (controller) {
          return Container(
            color: Colors.white,
            height: height,
            width: width,
            child: Stack(
              children: [
                Container(
                  color: Colors.blue,
                  height: height * 0.63,
                  width: width,
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: controller.pageController,
                          children: [
                            SizedBox(
                              width: width,
                              height: height * 0.63,
                              child: Image.asset(
                                AssetsRes.homeImage,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.6,
                              child: Image.asset(
                                AssetsRes.homeImage,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.6,
                              child: Image.asset(
                                AssetsRes.homeImage,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                            SizedBox(
                              width: width,
                              height: height * 0.6,
                              child: Image.asset(
                                AssetsRes.homeImage,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: height * 0.52,
                  child: SizedBox(
                    width: width,
                    child: Align(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: controller.pageController!,
                        count: 4,
                        effect: const WormEffect(
                          spacing: 3.5,
                          dotColor: ColorRes.color979797,
                          activeDotColor: ColorRes.colorWhite,
                          radius: 1,
                          dotWidth: 28,
                          dotHeight: 3,
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * 0.45,
                    width: width,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.06, vertical: height * 0.02),
                    decoration: const BoxDecoration(
                      color: ColorRes.colorWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AssetsRes.appLogo,
                              width: width * 0.088,
                            ),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            Text(
                              StringRes.appName,
                              style: TextStyle(fontSize: width * 0.06),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: width * 0.05),
                          child: Text(
                            StringRes.introOnBoard,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: width * 0.07),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            height: height * 0.075,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03,
                                vertical: height * 0.015),
                            decoration: BoxDecoration(
                              color: ColorRes.color8401FF,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                StringRes.createAccount,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w500,
                                    color: ColorRes.colorWhite),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: height*0.01,),
                        GestureDetector(
                          onTap: (){},
                          child: Container(
                            height: height * 0.075,
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.03,
                                vertical: height * 0.015),
                            decoration: BoxDecoration(
                              color: ColorRes.colorBlack,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Text(
                                StringRes.signIn,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: width * 0.045,
                                    fontWeight: FontWeight.w500,
                                    color: ColorRes.colorWhite),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  //
  // Column(
  // children: [
  // PageView(
  // controller: controller.pageController,
  // children: [
  // SizedBox(
  // width: width,
  // height: height*0.6,
  // child: Image.asset(
  // AssetsRes.homeImage,
  // fit: BoxFit.fitWidth,
  // ),
  // ),
  // SizedBox(
  // width: width,
  // height: height*0.6,
  // child: Image.asset(
  // AssetsRes.homeImage,
  // fit: BoxFit.fitWidth,
  // ),
  // ),
  // SizedBox(
  // width: width,
  // height: height*0.6,
  // child: Image.asset(
  // AssetsRes.homeImage,
  // fit: BoxFit.fitWidth,
  // ),
  // ),
  // SizedBox(
  // width: width,
  // height: height*0.6,
  // child: Image.asset(
  // AssetsRes.homeImage,
  // fit: BoxFit.fitWidth,
  // ),
  // ),
  //
  // ],
  // ),
  // const SizedBox(height: 10),
  // SmoothPageIndicator(
  // controller: controller.pageController!,
  // count: 4,
  // effect: const WormEffect(
  // spacing: 16,
  // dotColor: Colors.black,
  // activeDotColor: Colors.red,
  // radius: 0,
  // dotWidth: 25,
  // dotHeight: 5,
  // ),
  // )
  // // Row(
  // //   mainAxisAlignment: MainAxisAlignment.center,
  // //   children: [
  // //     _buildIndicator(controller.currentPage, 0),
  // //     SizedBox(width: 10),
  // //     _buildIndicator(controller.currentPage, 1),
  // //     SizedBox(width: 10),
  // //     _buildIndicator(controller.currentPage, 2),
  // //     SizedBox(width: 10),
  // //     _buildIndicator(controller.currentPage, 3),
  // //   ],
  // // ),
  // ],
  // );

  // Widget _buildIndicator(double currentPage, int index) {
  //   double selectedSize = 10;
  //   double unselectedSize = 6;
  //   double selectedOpacity = 1;
  //   double unselectedOpacity = 0.4;
  //
  //   double size = index == currentPage.floor() ? selectedSize : unselectedSize;
  //   double opacity =
  //       index == currentPage.floor() ? selectedOpacity : unselectedOpacity;
  //
  //   return Opacity(
  //     opacity: opacity,
  //     child: Container(
  //       width: size,
  //       height: size,
  //       decoration: const BoxDecoration(
  //         shape: BoxShape.circle,
  //         color: Colors.black,
  //       ),
  //     ),
  //   );
  // }
}

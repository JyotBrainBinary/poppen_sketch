import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/screen/home_screen/widget/home_top_area.dart';
import 'package:sketch/screen/home_screen/widget/onVideoUi.dart';
import 'package:sketch/screen/home_screen/widget/videoPlayerWidget.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(HomeController());
  final ProfileController profileController = Get.put(ProfileController());
  List videoUrl = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
  ];
  // VideoPlayerController? controller2;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Obx(
          () => controller.businessListModel.value.data == null
              ? const SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorRes.color8401FF,
                    ),
                  ),
                )
              : GestureDetector(
                  onTap: () {
                    controller.isDrop.value = false;
                  },
                  child: PageView.builder(
                      //controller: pageController,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          controller.businessListModel.value.data!.length,
                      itemBuilder: (context, index) {
                        return Obx(
                          () => controller.businessListModel.value.data![index]
                                  .coverResizeUrl
                                  .toString()
                                  .contains("mp4")
                              ? VideoPlayerWidget(
                                  video: controller.businessListModel.value
                                      .data![index].coverResizeUrl
                                      .toString(),
                                  autoPlay: true,
                                  index: index,
                                )
                              : Stack(
                                  children: [
                                    Image.network(
                                      controller.businessListModel.value
                                          .data![index].coverResizeUrl
                                          .toString(),
                                      height: Get.height,
                                      width: Get.width,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(AssetsRes.homeImage,
                                            height: Get.height,
                                            width: Get.width,
                                            fit: BoxFit.cover);
                                      },
                                    ),
                                    onImageUi(index: index),
                                  ],
                                ),
                        );
                      }),
                ),
        ),
        HomeTopArea(),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: Get.height*0.13,
            width: Get.width*0.055,
            decoration:  BoxDecoration(
                gradient:  LinearGradient(
            // color: Colors.amber,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.45),
                    ],
                      // ColorRes.colorBlack.withOpacity(.35),
                    stops: [0, 2],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated
                )
            ),

          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Container(
            height: Get.height*0.13,
            width: Get.width*0.055,
            decoration:  BoxDecoration(
                gradient:  LinearGradient(
            // color: Colors.amber,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(.45),
                    ],
                      // ColorRes.colorBlack.withOpacity(.35),
                    stops: [0, 2],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    tileMode: TileMode.repeated
                )
            ),

          ),
        ),
      ],
    );

    // PageView.builder(
    //   //controller: pageController,
    //   scrollDirection: Axis.vertical,
    //   itemCount: videoUrl.length,
    //   itemBuilder: (context, index) {
    //     return VideoPlayerWidget(
    //       video: videoUrl[index],
    //       autoPlay: true,
    //     );
    //   });
  }
}

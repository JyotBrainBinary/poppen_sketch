import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Profile/profileScreen.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:video_player/video_player.dart';

class HomeCenterArea extends StatelessWidget {
   HomeCenterArea({
    super.key, required this.videoController, required this.index,
  });
  final VideoPlayerController videoController;
  final int index;
  final controller = Get.find<HomeController>();



  @override
  Widget build(BuildContext context) {
    final item = controller.businessListModel.value.data![index];
    print("item------ ${item.toString()}");
    return Column(
      children: [
        InkWell(
          onTap: () async {
            await videoController.pause();
            Get.to(() => ProfileScreen());
          },
          child: Image.network(
            item.logoUrl.toString(),
            errorBuilder: (context, error, stackTrace) {
              
            },
            height: Get.height * 0.1,
          ),
        ),
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
          child: Text(
            "Republiq Bar & Grill",
            style: regular(color: ColorRes.colorBlack),
          ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Restaurant",
                    style: regular(fontSize: 12),
                  ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Date Night",
                    style: regular(fontSize: 12),
                  ),
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
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Bar",
                    style: regular(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
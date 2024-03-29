import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/screen/Profile/profileScreen.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:video_player/video_player.dart';

class HomeCenterArea extends StatelessWidget {
  HomeCenterArea({
    super.key,
    required this.videoController,
    required this.index,
  });
  final VideoPlayerController videoController;
  final int index;
  final controller = Get.find<HomeController>();
  final profileController = Get.find<ProfileController>();

  double height = Get.height;
  double width = Get.width;
  @override
  Widget build(BuildContext context) {
    final item = controller.businessListModel.value.data![index];
    final catagoryList = item.category!.split(",").toList();
    print("item------ ${item.toString()}");
    print("catagoryList: ---------$catagoryList");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
SizedBox(height: height*0.015,),
        ///api data
        InkWell(
          onTap: () async {
            await videoController.pause();
            profileController.callViewBusinessApi(id: item.id.toString());
            profileController.isLoading.value = true;
            Get.to(
              () => ProfileScreen(),
            );
          },
          child: Container(
            height: height * 0.085,
            width: height * 0.085,
            // padding: EdgeInsets.only(bottom: height*0.02,),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: Image.network(
                item.logoUrl.toString(),
                height: height * 0.085,
                width: height * 0.085,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Image.asset(
                    AssetsRes.restaurantLogo,
                    height: height * 0.085,
                    width: height * 0.085,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AssetsRes.restaurantLogo,
                    height: height * 0.085,
                    width: height * 0.085,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
        ),
        SizedBox(height: height*0.01,),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.006),

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
            item.name.toString(),
            style: regular(color: ColorRes.colorBlack,fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: height * 0.045,
          // width: width,

          child: Align(
            alignment: Alignment.center,
            child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: catagoryList.length,
              separatorBuilder: (context, index) {
                return SizedBox(
                  width: width * 0.02,
                );
              },
              itemBuilder: (context, index) {

                // print("data:=========   ${ controller.categoryNameList[
                // int.parse(catagoryList[index].toString())]}");

                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.025, vertical: height * 0.001),
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
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(
                        controller.categoryNameList[
                            int.parse(catagoryList[index].toString())],
                        style: regular(fontSize: 12,fontWeight: FontWeight.w600,color: ColorRes.colorWhite),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),



      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class FeedScreen extends StatelessWidget {
   FeedScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    return SizedBox(
      height: Get.height*0.71,
      child: Column(
        children: [
           const SizedBox(height: 10),
         SizedBox(
           height: Get.height*0.69,
           child: GridView.builder(
           shrinkWrap: true,
           physics: const NeverScrollableScrollPhysics(),
           // scrollDirection: Axis.vertical,
           itemCount: profileController.viewBusinessModel.value.data!.galleryList!.length,
           itemBuilder: (context, index) {
             final item = profileController.viewBusinessModel.value.data!.galleryList![index];
             return Image.network(
               item.toString(),
               height: Get.height * 0.2,
               width: Get.height * 0.2,
               fit: BoxFit.cover,
               loadingBuilder: (BuildContext context, Widget child,
                   ImageChunkEvent? loadingProgress) {
                 if (loadingProgress == null) return child;
                 return Image.asset(
                   AssetsRes.restaurantLogo,
                   height: Get.height * 0.2,
                   width: Get.height * 0.2,
                 );
               },
               errorBuilder: (context, error, stackTrace) {
                 return Image.asset(
                   AssetsRes.restaurantLogo,
                   height: Get.height * 0.2,
                   width: Get.height * 0.2,
                   fit: BoxFit.cover,
                 );
               },
             );
             //   Container(
             //   height: 220,
             //   decoration:  BoxDecoration(
             //     color: ColorRes.colorBlack,
             //     image: DecorationImage(
             //       image: AssetImage(profileController.feedImage[index]),
             //       fit: BoxFit.cover
             //     ),
             //   ),
             // );
           },
           gridDelegate:
           const SliverGridDelegateWithFixedCrossAxisCount(
               crossAxisCount: 3,
               crossAxisSpacing: 1,
               mainAxisSpacing: 1,
               childAspectRatio: 1.9 / 2.6
           ),
           ),
         ),
        ],
      ),
    );
  }
}



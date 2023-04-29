import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/Profile/profileController.dart';
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
             return  Container(
               height: 220,
               decoration:  BoxDecoration(
                 color: ColorRes.colorBlack,
                 image: DecorationImage(
                   image: AssetImage(profileController.feedImage[index]),
                   fit: BoxFit.cover
                 ),
               ),
             );
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



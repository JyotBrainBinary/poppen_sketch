import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/utils/color_res.dart';

class FeedScreen extends StatelessWidget {
   FeedScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Column(
      children: [
         const SizedBox(height: 10),
       Expanded(
         child: GridView.builder(
         shrinkWrap: true,
         scrollDirection: Axis.vertical,
         itemCount: profileController.feedImage.length,
         itemBuilder: (context, index) {
           return  Container(
             height: 250,
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
    );
  }
}



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Expanded(
      child: Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.06),
            Row(
              children: [
                Image.asset(AssetsRes.location, height: 18),
                SizedBox(width: Get.width * 0.04),
                Text(StringRes.address, style: regular(color: ColorRes.color161823),),

              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Container(
              height: 50,
              width: Get.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorRes.colorE9E9E9)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text("The Grand Parade, Brighton-Le-Sands NSW"),
                  ],
                ),
              ),
            ),
            SizedBox(height: Get.height * 0.04),
            Row(
              children: [
                Image.asset(AssetsRes.phone, height: 15),
                SizedBox(width: Get.width * 0.04),
                Text(StringRes.phoneNumber, style: regular(color: ColorRes.color161823),),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Container(
              height: 50,
              width: Get.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorRes.colorE9E9E9)
              ),
              child: Text("(02) 9599 1018"),
            ),
            SizedBox(height: Get.height * 0.04),
            Row(
              children: [
                Image.asset(AssetsRes.timer, height: 15),
                SizedBox(width: Get.width * 0.04),
                Text(StringRes.openingHours, style: regular(color: ColorRes.color161823),),
              ],
            ),
            SizedBox(height: Get.height * 0.02),
            Container(
              width: Get.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: ColorRes.colorE9E9E9)
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(profileController.weekList.length, (index) =>
                        Column(

                          children: [
                            Text(profileController.weekList[index], style: regular(color: ColorRes.color161823),),
                            SizedBox(height: 10,),
                          ],
                        ),
                    ),
                  ),
                  SizedBox(width: Get.width * 0.2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(profileController.weekTimeList.length, (index) =>
                        Column(

                          children: [
                            Text(profileController.weekTimeList[index], style: regular(color: ColorRes.color161823),),
                            SizedBox(height: 10,),
                          ],
                        ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.04),
          ],
        ),
      ),
    ),);
  }


}

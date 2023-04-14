import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.035),
            /// ------- App Bar ------------------
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (){
                      Get.back();
                    },
                    child: Image.asset(AssetsRes.backButton, height: 18),
                  ),
                  Text("@RQREPUBLIQ", style: regular(color: ColorRes.color161823, fontSize: 18, fontWeight: FontWeight.w300),),
                  const Icon(Icons.more_horiz, color: ColorRes.color161823,),
                ],
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            const Divider(
              thickness: 1.5,
              color: ColorRes.colorD5D6D7,
            ),


            /// --------- Profile -----------------
            SizedBox(height: Get.height * 0.018),
            Image.asset(AssetsRes.restaurantLogo, height: Get.height * 0.17),
            SizedBox(height: Get.height * 0.015,),
            Text("Republiq Bar & Grill", style: regular(fontSize: 18, color: ColorRes.color161823, fontWeight: FontWeight.w300),),
            Text("WWW.RQREPUBLIQ.COM.AU", style: regular(color: ColorRes.color7F0E1A, fontWeight: FontWeight.w300, fontSize: 12),),
            SizedBox(height: Get.height * 0.025,),
            Text("🍽 Middle Eastern and Mediterranean Cuisine", style: regular(fontSize: 12, color: ColorRes.color979797),),
            Text("🍸 World Class Bar", style: regular(fontSize: 12, color: ColorRes.color979797),),
            Text("📍 Heart of Brighton-Le-Sands", style: regular(fontSize: 12, color: ColorRes.color979797),),

            SizedBox(height: Get.height * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * 0.04,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorRes.color161823,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.02,
                        width: Get.width * 0.035,
                        color: ColorRes.colorWhite,
                      ),
                      const SizedBox(width: 10,),
                      Text("Restaurant", style: regular(fontSize: 12),),
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
                    color: ColorRes.color161823,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.02,
                        width: Get.width * 0.035,
                        color: ColorRes.colorWhite,
                      ),
                      const SizedBox(width: 10,),
                      Text("Date Night", style: regular(fontSize: 12),),
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
                    color: ColorRes.color161823,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: Get.height * 0.02,
                        width: Get.width * 0.035,
                        color: ColorRes.colorWhite,
                      ),
                      const SizedBox(width: 10,),
                      Text("Bar", style: regular(fontSize: 12),),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.03),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.28,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorRes.colorE9E9E9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AssetsRes.direction, height: 20),
                        const SizedBox(width: 10,),
                        Text(StringRes.directions, style: regular(fontSize: 12, color: ColorRes.colorBlack),),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.28,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorRes.colorE9E9E9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: Get.height * 0.02,
                          width: Get.width * 0.045,
                          decoration: BoxDecoration(
                            color: ColorRes.color161823,
                            borderRadius: BorderRadius.circular(5),
                          ),

                        ),
                        const SizedBox(width: 10,),
                        Text(StringRes.message, style: regular(fontSize: 12, color: ColorRes.colorBlack),),
                      ],
                    ),
                  ),
                  Container(
                    height: Get.height * 0.055,
                    width: Get.width * 0.28,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: ColorRes.colorE9E9E9,
                    ),
                    child: Text(StringRes.bookNow, style: regular(fontSize: 12, color: ColorRes.colorBlack),),
                  ),

                ],
              ),
            ),

            /// ------ post --------------
            const Divider(
              thickness: 1.5,
              color: ColorRes.colorD5D6D7,
            ),
          ],
        ),
      ),
    );
  }
}

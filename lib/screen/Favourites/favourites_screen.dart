import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/bottomBar.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: Get.height * 0.035),
            /// --------- App Bar ------------------
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text("Favourites", style: regular(color: ColorRes.color161823, fontSize: 18, fontWeight: FontWeight.w300),),
              ),
            ),
            SizedBox(height: Get.height * 0.01),
            const Divider(
              thickness: 1.5,
              color: ColorRes.colorD5D6D7,
            ),
            SizedBox(height: Get.height * 0.02),
            favouriteBox(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
    );
  }
  Widget favouriteBox(){
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: Column(
        children: [
          Container(
            height: Get.height * 0.3,
            width: Get.width,
            decoration: BoxDecoration(
              border: Border.all(color: ColorRes.colorE9E9E9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Align(

                  child: Container(
                    height: 20,
                    width: 20,
                    color: ColorRes.colorEFC744,
                  ),
                  alignment: Alignment.topRight,
                ),
                Row(
                  children: [
                    Image.asset(AssetsRes.restaurantLogo, height: 50),
                    Column(
                      children: [
                        Text("Republiq Bar & Grill", style: regular(color: ColorRes.color161823),),
                        Row(
                          children: [

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

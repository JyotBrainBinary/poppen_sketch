import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/auth/login/login_screen.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

class WhatIntrestedScreen extends StatelessWidget {
  const WhatIntrestedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: ColorRes.colorWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonTopAuthScreen(
                height: height,
                width: width,
                title: StringRes.whatIntrested,
              ),
              SizedBox(
                height: height * 0.02,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: 9,
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: width * 0.012,
                    childAspectRatio: 2.5),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.025),
                    decoration: BoxDecoration(
                      color: ColorRes.colorBlack,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: width * 0.04,
                          width: width * 0.04,
                          color: (index + 1) % 2 == 0
                              ? Colors.black
                              : (index + 1) % 3 == 0
                                  ? Colors.red
                                  : ColorRes.color8401FF,
                        ),
                        SizedBox(
                          width: width * 0.015,
                        ),
                        const Text(
                          StringRes.restaurants,
                          style: TextStyle(
                              color: ColorRes.colorWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CommonButton(
                height: height,
                width: width,
                color: ColorRes.color8401FF,
                text: StringRes.startDiscovering,
                isRightArrow: true,
                onTap: () {
                  Get.to(() => const LoginScreen());
                },
              ),
              Spacer(),
              SizedBox(
                height: height * 0.05,
              ),
              CommonCreateAccText(
                text1: StringRes.doNotHaveAc,
                text2: StringRes.createOne,
                onTap: () {},
              ),
              SizedBox(
                height: height * 0.055,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

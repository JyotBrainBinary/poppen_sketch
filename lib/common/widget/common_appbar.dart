import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class CommonAppBar extends StatelessWidget {
  CommonAppBar({
    super.key,
    this.index,
  });
  final int? index;

  double height = Get.height;
  double width = Get.width;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.035),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03,vertical: height*0.002),
          child: Row(
            mainAxisAlignment: index == 4
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.start,
            children: [
              index == 4
                  ? GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(right: 5),
                        color: Colors.transparent,
                        child: Image.asset(
                          AssetsRes.backButton,
                          height: height * 0.03,
                        ),
                      ),
                    )
                  : const SizedBox(),
              Align(
                alignment: index == 4 ? Alignment.center : Alignment.centerLeft,
                child: SizedBox(
                  child: Text(
                    index == 4 ? "Profile" : "Favourites",
                    textAlign: TextAlign.center,
                    style: regular(
                        color: ColorRes.color161823,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
              index == 4
                  ? Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 1),
                      color: Colors.transparent,
                      child: Image.asset(
                        AssetsRes.dotsImg,
                        height: width * 0.01,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        const Divider(
          thickness: 1.5,
          height: 1.5,
          color: ColorRes.colorD5D6D7,
        ),

      ],
    );
  }
}

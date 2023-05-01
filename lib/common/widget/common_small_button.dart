import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/color_res.dart';

class CommonSmallButton extends StatelessWidget {
  CommonSmallButton({
    super.key,
    required this.ontap,
    required this.image,
    required this.text,
  });
  final VoidCallback ontap;
  final String image;
  final String text;
  double width = Get.width;
  double height = Get.height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: (width * 0.9)/2,
        height: height * 0.07,
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.02, vertical: height * 0.01),
        decoration: const BoxDecoration(
          color: ColorRes.colorE9E9E9,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              image,
              color: ColorRes.colorBlack,
              width: width * 0.05,
            ),
            SizedBox(
              width: width * 0.02,
            ),
            Text(
              text,
              style: const TextStyle(fontSize: 12),
            ),

          ],
        ),
      ),
    );
  }
}
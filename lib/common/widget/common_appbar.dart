import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/utils/color_res.dart';

class CommonAppBar extends StatelessWidget {
  const CommonAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: Get.height * 0.035),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Favourites",
              style: regular(
                  color: ColorRes.color161823,
                  fontSize: 18,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ),
        SizedBox(height: Get.height * 0.01),
        const Divider(
          thickness: 1.5,
          color: ColorRes.colorD5D6D7,
        ),
        SizedBox(height: Get.height * 0.02),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class CommonAuthBottomArea extends StatelessWidget {
  CommonAuthBottomArea({
    super.key,
    required this.onGoogleTap,
    required this.onFacebookTap,
  });

  final VoidCallback onGoogleTap;
  final VoidCallback onFacebookTap;

  double height = Get.height;
  double width = Get.width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: const [
          Expanded(
              child: Divider(
            color: ColorRes.colorD8D8D8,
            thickness: 1,
            height: 1,
          )),
          Text(
            "    OR    ",
            style: TextStyle(fontSize: 14, color: ColorRes.colorB0B0B0),
          ),
          Expanded(child: Divider()),
        ]),
        SizedBox(
          height: height * 0.02,
        ),
        _buildButton(
            image: AssetsRes.google,
            text: StringRes.signInWithGoogle,
            ontap: onGoogleTap),
        SizedBox(
          height: height * 0.01,
        ),
        _buildButton(
            image: AssetsRes.facebook,
            text: StringRes.signInWithFacebook,
            ontap: onFacebookTap),
      ],
    );
  }

  Widget _buildButton(
      {required String image,
      required String text,
      required VoidCallback ontap}) {
    return GestureDetector(
      onTap: onGoogleTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.017),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorRes.colorEBEBEB),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: width * 0.067,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              text,
              style: const TextStyle(
                  fontSize: 14,
                  color: ColorRes.colorBlack,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

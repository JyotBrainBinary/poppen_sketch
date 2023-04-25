import 'package:flutter/material.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';

class CommonTopAuthScreen extends StatelessWidget {
  const CommonTopAuthScreen({
    super.key,
    required this.height,
    required this.width, required this.title, this.isOtpVerify,
  });

  final double height;
  final double width;
  final String title;
  final bool? isOtpVerify;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: height * 0.08,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              AssetsRes.appLogo,
              width: width * 0.088,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              StringRes.appName,
              style: TextStyle(fontSize: width * 0.065),
            ),
          ],
        ),
        SizedBox(
          height: height * 0.05,
        ),
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: width * 0.065),
        ),
        isOtpVerify == true ? const SizedBox() : SizedBox(
          height: height * 0.04,
        ),
      ],
    );
  }
}
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sketch/utils/color_res.dart';

class CommonCreateAccText extends StatelessWidget {
  const CommonCreateAccText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,
  });
  final String text1;
  final String text2;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: text1,
          style: const TextStyle(color: ColorRes.color707070, fontSize: 14),
          children: <TextSpan>[
            TextSpan(
                text: text2,
                style:
                const TextStyle(color: ColorRes.color8401FF, fontSize: 14),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
      ),
    );
  }
}
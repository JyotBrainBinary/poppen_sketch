import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sketch/utils/color_res.dart';

class CommonCreateAccText extends StatelessWidget {
  const CommonCreateAccText({
    super.key,
    required this.text1,
    required this.text2,
    required this.onTap,  this.canResend,
  });
  final String text1;
  final String text2;
  final VoidCallback onTap;
  final bool? canResend;

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
                 TextStyle(color:  canResend == false  ?  ColorRes.color707070 : ColorRes.color8401FF, fontSize: 14),
                recognizer: TapGestureRecognizer()..onTap = onTap),
          ],
        ),
      ),
    );
  }
}
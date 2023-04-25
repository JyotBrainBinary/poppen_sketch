import 'package:flutter/material.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.text,
    required this.onTap,
    this.isRightArrow
  });

  final double height;
  final double width;
  final Color color;
  final String text;
  final VoidCallback onTap;
  final bool? isRightArrow;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height * 0.075,
        padding: EdgeInsets.symmetric(
           horizontal: width*0.03,  vertical: height * 0.015),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child:isRightArrow == true? Row(
          children: [
            SizedBox(
              width: width * 0.83,
              child: Padding(
                padding:  EdgeInsets.only(left:width*0.03),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w500,
                      color: ColorRes.colorWhite),
                ),
              ),
            ),
            SizedBox(
              width: width*0.026,
              child: Image.asset(
                AssetsRes.arrowRight,
                width: width*0.026,
                color: ColorRes.colorWhite,
              ),
            ),
          ],
        ) : Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                color: ColorRes.colorWhite),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sketch/utils/color_res.dart';


TextStyle regularShaow({Color? color,
  double? fontSize,
  double? letterSpacing,
  FontWeight? fontWeight}){
  return TextStyle(
  color: color ?? ColorRes.colorWhite,
fontWeight: fontWeight ?? FontWeight.w400,
fontSize: fontSize ?? 14,
//fontFamily: FontRes.poppinsRegular,
letterSpacing: letterSpacing ?? 0,
    shadows: <Shadow>[
      Shadow(
        blurRadius: 3.0,
        color: ColorRes.colorBlack.withOpacity(0.5),
      ),

    ],
);
}

TextStyle regular(
    {Color? color,
      double? fontSize,
      double? letterSpacing,
      FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? ColorRes.colorWhite,
    fontWeight: fontWeight ?? FontWeight.w400,
    fontSize: fontSize ?? 14,
    //fontFamily: FontRes.poppinsRegular,
    letterSpacing: letterSpacing ?? 0,
  );
}

TextStyle medium(
    {Color? color,
      double? fontSize,
      double? letterSpacing,
      FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? ColorRes.colorWhite,
    fontWeight: fontWeight ?? FontWeight.w500,
    fontSize: fontSize ?? 14,
    //fontFamily: FontRes.poppinsMedium,
    letterSpacing: letterSpacing ?? 0,
  );
}

TextStyle semiBold(
    {Color? color,
      double? fontSize,
      double? letterSpacing,
      FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? ColorRes.colorWhite,
    fontWeight: fontWeight ?? FontWeight.w600,
    fontSize: fontSize ?? 14,
    //fontFamily: FontRes.poppinsSemiBold,
    letterSpacing: letterSpacing ?? 0,
  );
}


TextStyle bold(
    {Color? color,
      double? fontSize,
      double? letterSpacing,
      FontWeight? fontWeight}) {
  return TextStyle(
    color: color ?? ColorRes.colorWhite,
    fontWeight: fontWeight ?? FontWeight.bold,
    fontSize: fontSize ?? 14,
    //fontFamily: FontRes.poppinsSemiBold,
    letterSpacing: letterSpacing ?? 0,
  );
}
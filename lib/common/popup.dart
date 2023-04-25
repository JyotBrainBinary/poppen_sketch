import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

void errorToast(String error, {String? title}) {
  Get.snackbar(
    title ?? StringRes.errorText,
    error,
    duration: const Duration(seconds: 1),
    colorText: ColorRes.colorWhite,
    backgroundColor: ColorRes.colorRed,
  );
}

void flutterToast(String value, {String? title}) {
  Get.snackbar(
    title ?? StringRes.successText,
    value,
    duration: const Duration(seconds: 1),
    colorText: ColorRes.colorWhite,
    backgroundColor: Colors.green,
  );
}
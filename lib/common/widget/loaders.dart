import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/color_res.dart';


class FullScreenLoader extends StatelessWidget {
  final bool? enableBgColor;

  const FullScreenLoader({Key? key, this.enableBgColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      decoration: enableBgColor == true
          ?   BoxDecoration(
        color: ColorRes.color707070.withOpacity(.65)
        // gradient: LinearGradient(
        //   colors: [
        //     ColorRes.colorRed,
        //     ColorRes.color8401FF,
        //   ],
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomCenter,
        // ),
      )
          : null,
      child: Center(
        child: Platform.isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(color: ColorRes.color8401FF,),
      ),
    );
  }
}

class SmallLoader extends StatelessWidget {
  const SmallLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? const CupertinoActivityIndicator()
          : const CircularProgressIndicator(),
    );
  }
}

class SmartLoader extends StatelessWidget {
  const SmartLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Platform.isIOS
            ? const CupertinoActivityIndicator()
            : const CircularProgressIndicator(),
      ),
    );
  }
}

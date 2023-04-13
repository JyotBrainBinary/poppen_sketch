import 'package:flutter/material.dart';

import 'package:get/route_manager.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';





class DashBoardScreen extends StatefulWidget {
   DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
              height: Get.height,
              width: Get.width,
              child: Image.asset(AssetsRes.homeImage)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: Get.height * 0.07142),
                  padding: EdgeInsets.symmetric(
                      vertical: 7, horizontal: Get.width * 0.0347),
                  decoration: BoxDecoration(color: ColorRes.containerColor),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 11,
                        width: 11,
                        color: ColorRes.redContainer,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

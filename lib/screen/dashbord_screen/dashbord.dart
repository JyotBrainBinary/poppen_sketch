import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/chat/String.dart';
import 'package:sketch/chat/firebase_chat_manager.dart';
import 'package:sketch/chat/user_side_screen/chat_fire_screen.dart';
import 'package:sketch/common/bottomBar.dart';
import 'package:sketch/common/widget/common_appbar.dart';
import 'package:sketch/screen/Favourites/favourites_screen.dart';

import 'package:sketch/screen/dashbord_screen/dashboard_controller.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:sketch/utils/pref_key.dart';

class DashBoardScreen extends StatelessWidget {
  DashBoardScreen({super.key});
  final controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashBoardController>(
      id: "bottomBar",
      builder: (controller) {
        return Scaffold(
          backgroundColor: controller.selectedIndex == 0
              ? Colors.black
              : ColorRes.colorWhite,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: controller.widgetOptions
                        .elementAt(controller.selectedIndex),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: bottomNavigationBar(context),
        );
      },
    );
  }
}

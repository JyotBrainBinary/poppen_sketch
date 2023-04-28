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
          floatingActionButton: GestureDetector(
            onTap: () async {
              // CUR_USERID = (await getPrefrence(ID))!;
              // if (CUR_USERID != null) {
                // setState(() {});

              var  isManager = PrefService.getString(PrefKeys.isManager);

                if (isManager == "true") {
                 Navigator.push(context,
                     MaterialPageRoute(builder: (_) => ChatManager()));
                } else {
                  showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      )),
                      builder: (builder) {
                        // roomId =PrefService.getString(PrefKeys.uid);
                        return StatefulBuilder(
                          builder:
                              (BuildContext context, StateSetter setState) {
                            setState = setState;
                            return Container(
                              height: MediaQuery.of(context).size.height / 1.1,
                              child: ChatFireScreen(
                                isManager: false,
                                roomId: PrefService.getString(PrefKeys.uid),
                              ),
                            );
                          },
                        );
                      }).then((value) {
                    // init();
                  });
                }
              // } else {
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => Login(),
                //     ));
              // }
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff341069),
              ),
            ),
          ),
          backgroundColor: controller.selectedIndex == 0
              ? Colors.black
              : ColorRes.colorWhite,
          body: SafeArea(
            child: Column(
              children: [
                controller.selectedIndex != 0
                    ?  CommonAppBar(index: controller.selectedIndex,)
                    : const SizedBox(),
                Expanded(
                  child: Center(
                    child: controller.widgetOptions
                        .elementAt(controller.selectedIndex),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar:
              bottomNavigationBar(context),
        );
      },
    );
  }
}

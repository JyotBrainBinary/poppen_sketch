import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/chat/String.dart';
import 'package:sketch/chat/chat_room_service.dart';
import 'package:sketch/chat/model/room_model.dart';
import 'package:sketch/chat/user_card.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:sketch/utils/pref_key.dart';

class ChatManager extends StatefulWidget {
  const ChatManager({Key? key}) : super(key: key);

  @override
  State<ChatManager> createState() => _ChatManagerState();
}

class _ChatManagerState extends State<ChatManager> {
  String? mobileNo;
  bool isMsg = true;
  @override
  void initState() {
    // checkVersion(context);
    getMobile();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // checkVersion(context);
    super.didChangeDependencies();
  }

  getMobile() async {
    mobileNo = PrefService.getString(PrefKeys.uid);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
              padding: const EdgeInsets.symmetric(vertical: 19),
              height: 17.64,
              child: Image.asset(
                AssetsRes.backButton,
                fit: BoxFit.fitHeight,
              )),
        ),
        backgroundColor: ColorRes.colorWhite,
        title: const Text(
          StringRes.chats,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 22),
        ),
        elevation: 1,
        actions: [
          InkWell(
            onTap: () async {
              // launch('tel://9409075553');
              // const number = '+44 7570298692'; //set the number here
              // await FlutterPhoneDirectCaller.callNumber(number);
            },
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: 18),
                margin: const EdgeInsets.only(right: 16),
                child: Image.asset(
                  AssetsRes.dotsImg, height: 4,
                  width: 16,
                  // fit: BoxFit.fitHeight,
                )),
          )
        ],
      ),
      body: Column(
        children: [
          // Row(
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         isMsg = true;
          //         setState(() {});
          //       },
          //       child: Container(
          //         height: 31,
          //         width: Get.width * 0.5,
          //         color: Colors.transparent,
          //         alignment: Alignment.center,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             SizedBox(
          //               height: 12,
          //               child: Image.asset(
          //                 AssetsRes.msg,
          //                 color: isMsg
          //                     ? ColorRes.colorBlack
          //                     : ColorRes.colorD7D7D9,
          //               ),
          //             ),
          //             const SizedBox(width: 12),
          //             Text(
          //               StringRes.message,
          //               style: TextStyle(
          //                   color: isMsg
          //                       ? ColorRes.colorBlack
          //                       : ColorRes.colorD7D7D9,
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 12),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () {
          //         isMsg = false;
          //         setState(() {});
          //       },
          //       child: Container(
          //         height: 31,
          //         width: Get.width * 0.5,
          //         color: Colors.transparent,
          //         alignment: Alignment.center,
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             SizedBox(
          //               height: 12,
          //               child: Image.asset(
          //                 AssetsRes.bell,
          //                 color: isMsg
          //                     ? ColorRes.colorD7D7D9
          //                     : ColorRes.colorBlack,
          //               ),
          //             ),
          //             const SizedBox(width: 12),
          //             Text(
          //               StringRes.message,
          //               style: TextStyle(
          //                   color: isMsg
          //                       ? ColorRes.colorD7D7D9
          //                       : ColorRes.colorBlack,
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: 12),
          //             )
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),
          // Row(
          //   children: [
          //     Container(
          //         height: isMsg ? 2 : 0.5,
          //         width: Get.width * 0.5,
          //         color: isMsg ? ColorRes.colorBlack : ColorRes.colorD7D7D9),
          //     Container(
          //         height: isMsg ? 0.5 : 2,
          //         width: Get.width * 0.5,
          //         color: isMsg ?  ColorRes.colorD7D7D9:ColorRes.colorBlack )
          //   ],
          // ),
          // !isMsg? const Expanded(
          //   child: Center(child: Text(StringRes.
          //   notifications)),
          // ):
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ChatRoomservice().streamRooms(),
              builder: (context, roomSnapshot) {
                if (roomSnapshot.hasData) {
                  if (roomSnapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No users found"),
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          itemCount: roomSnapshot.data?.docs.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            Map map =
                                roomSnapshot.data?.docs[index].data() as Map;
                            if (map['lastMessage'] == "") {
                              Mmessage mmessage = Mmessage.fromMap(
                                  roomSnapshot.data?.docs[index].data()
                                      as Map<String, dynamic>);
                              return UserCard(
                                mmessage: mmessage,
                                typing: false,
                                newBadge: map['${map['id'] + "_newMessage"}'],
                                isAllow: true,
                              );
                            } else {
                              RoomModel roomModel = RoomModel.fromMap(
                                  roomSnapshot.data?.docs[index].data()
                                      as Map<String, dynamic>);
                              Map map =
                                  roomSnapshot.data?.docs[index].data() as Map;
                              //  int messageCount = int.parse(map['${map['id']+"_newMessage"}'].toString());
                              print(map['${map['id'] + "_newMessage"}']);
                              //var newMessageCount = roomSnapshot.data.docs[index].data()['name'].toString();
                              if (roomModel.isManager == "true") {
                                return const SizedBox();
                              } else {
                                return Dismissible(
                                  key: ValueKey<int>(index),
                                  secondaryBackground: slideLeftBackground(),
                                  background: Container(),
                                  direction: DismissDirection.endToStart,
                                  // ignore: missing_return
                                  confirmDismiss: (direction) async {
                                    if (direction ==
                                        DismissDirection.endToStart) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              content: const Text(
                                                  "Are you sure you want to delete?"),
                                              actions: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("No"),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    ChatRoomservice().deletedoc(
                                                        roomModel.id
                                                            .toString());

                                                    /*        ChatRoomService().deleteDoc(
                                                usrname,
                                                title,
                                                snapshot.data!.docs[index]['id']);*/
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text("Yes"),
                                                ),
                                              ],
                                            );
                                          });
                                    }
                                  },
                                  child: UserCard(
                                    user: roomModel,
                                    typing: false,
                                    newBadge:
                                        map['${map['id'] + "_newMessage"}'],
                                    isAllow: false,
                                  ),
                                );
                              }
                            }
                          }),
                    );
                  }
                } else {
                  return Center(
                    child: Platform.isIOS
                        ? const CupertinoActivityIndicator()
                        : const CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}

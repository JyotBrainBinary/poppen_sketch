import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/chat/String.dart';
import 'package:sketch/chat/chat_room_service.dart';
import 'package:sketch/chat/model/room_model.dart';
import 'package:sketch/chat/user_card.dart';
Future<String?> getPrefrence(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
  
}
setPrefrence(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value);
}
class ChatManager extends StatefulWidget {
  const ChatManager({Key? key}) : super(key: key);

  @override
  State<ChatManager> createState() => _ChatManagerState();
}

class _ChatManagerState extends State<ChatManager> {
  String? mobileNo;
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
  getMobile()async{
    mobileNo = await getPrefrence(MOBILE);
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back,color: Colors.white,),
        ),
        backgroundColor: const Color(0xFF200738),
        title: const Text(
          "Chat List",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                    itemCount: roomSnapshot.data?.docs.length?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      Map map = roomSnapshot.data?.docs[index].data() as Map;
                      if(map['lastMessage']==""){
                        Mmessage mmessage = Mmessage.fromMap(roomSnapshot.data?.docs[index].data() as Map<String,dynamic>);
                       return UserCard(
                          mmessage: mmessage,
                          typing: false,
                          newBadge: map['${map['id']+"_newMessage"}'],
                          isAllow: true,
                        );

                      }else{
                        RoomModel roomModel = RoomModel.fromMap(
                            roomSnapshot.data?.docs[index].data() as Map<String,dynamic>);
                        Map map = roomSnapshot.data?.docs[index].data() as Map;
                      //  int messageCount = int.parse(map['${map['id']+"_newMessage"}'].toString());
                        print(map['${map['id']+"_newMessage"}']);
                        //var newMessageCount = roomSnapshot.data.docs[index].data()['name'].toString();
                        if (roomModel.isManager=="true") {
                          return const SizedBox();
                        } else {
                          return Dismissible(
                            key: ValueKey<int>(index),
                            secondaryBackground: slideLeftBackground(),
                            background:Container(),
                            direction: DismissDirection.endToStart,
                            // ignore: missing_return
                            confirmDismiss: (direction)async{
                              if(direction == DismissDirection.endToStart){
                                showDialog(context: context, builder: (
                                    BuildContext context
                                    ){
                                  return AlertDialog(
                                    content: const Text("Are you sure you want to delete?"),
                                    actions: <
                                        Widget>[
                                      ElevatedButton(
                                        onPressed:
                                            () {
                                          Navigator.pop(
                                              context);
                                        },
                                        child: const Text(
                                            "No"),
                                      ),
                                      ElevatedButton(
                                        onPressed:
                                            () {
                                          ChatRoomservice().deletedoc(roomModel.id.toString());


                                          /*        ChatRoomService().deleteDoc(
                                          usrname,
                                          title,
                                          snapshot.data!.docs[index]['id']);*/
                                          Navigator.pop(
                                              context);
                                        },
                                        child: const Text(
                                            "Yes"),
                                      ),
                                    ],
                                  );
                                }
                                );
                              }

                            },
                            child: UserCard(
                              user: roomModel,
                              typing: false,
                              newBadge: map['${map['id']+"_newMessage"}'],
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
    );
  }
  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
         alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const[
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

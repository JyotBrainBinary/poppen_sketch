import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_picker/media_picker.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sketch/chat/String.dart';
import 'package:sketch/chat/chat_room_service.dart';
import 'package:sketch/chat/common/common_widget.dart';
import 'package:sketch/chat/common/widget.dart';
import 'package:sketch/chat/firebase_chat_manager.dart';
import 'package:sketch/chat/firebase_message_service.dart';
import 'package:sketch/chat/message_view.dart';
import 'package:sketch/chat/model/message_model.dart';
import 'package:sketch/chat/model/send_notification_model.dart';
import 'package:sketch/main.dart';
import 'package:sketch/screen/dashbord_screen/dashboard_controller.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:sketch/utils/pref_key.dart';

String? roomId;

class ChatFireScreen extends StatefulWidget {
  final String? roomId;
  final bool? isManager;
  final String? fcmToken;
  final String? name;
  final bool? isFromProfile;
  ChatFireScreen(
      {this.roomId,
      this.isManager,
      this.fcmToken,
      this.name,
      this.isFromProfile});

  @override
  State<ChatFireScreen> createState() => _ChatFireScreenState();
}

class _ChatFireScreenState extends State<ChatFireScreen> {
  bool isAttachment = false;
  bool isTyping = false;
  bool uploadingMedia = false;
  bool isLoading = true;
  String? username;
  String? chatId;
  MMessage? message;
  bool? isManager;

  bool isReply = false;
  final dashController = Get.find<DashBoardController>();

  final ImagePicker picker = ImagePicker();
  FocusNode focusNode = FocusNode();
  List<DocumentSnapshot> listMessage = [];
  List<MessageModel> selectedMessages = [];
  int chatLimit = 20;
  final ScrollController listScrollController = ScrollController();
  TextEditingController controller = TextEditingController();
  DocumentSnapshot? roomDocument;
  DocumentSnapshot? doc;
  String? mobile;
  List<String>? tokenList = [];
  String? fcmToken;
  String? anotherFcmToken;

  onTextFieldChange() {
    if (controller.text.isEmpty) {
      isTyping = false;
    } else {
      isTyping = true;
    }
    setState(() {});
  }

  roomIdExist() async {
    roomId = PrefService.getString(PrefKeys.uid);
    doc = await ChatRoomservice().isRoomAvailable(roomId!);
    print(roomId);
    if (doc!.exists) {
      isLoading = false;
    } else {
      isLoading = false;
      chatId = roomId;
    }
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {});
    });

    setState(() {});
  }

  setInitiaCount() async {
    if (widget.isManager!) {
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(widget.roomId)
          .update({"${widget.roomId! + "_newMessage"}": 0});
    } else {
      var mobileNo = PrefService.getString(PrefKeys.uid);
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(mobileNo)
          .update({"manager_newMessage": 0});
    }
  }

  void onCameraTap() async {
    isAttachment = false;
    final imagePath = await picker.getImage(source: ImageSource.camera);
    if (imagePath != null) {
      uploadingMedia = true;
      uploadingMedia = false;
    }
    setState(() {});
  }

  void onSend(MMessage message) async {
    if (controller.text.isNotEmpty) {
      sendMessage("text", controller.text.trim(), message);
      roomIdExist();
      print("object==========");
      controller.clear();
      isTyping = false;
    }
    setState(() {});
  }

  void sendMessage(String type, String content, MMessage message) async {
    var mobileNo = PrefService.getString(PrefKeys.uid);
    DateTime messageTime = DateTime.now();
    int count = 0;

    if (!doc!.exists) {
      await ChatRoomservice().createChatRoom({
        "id": roomId,
        "lastMessage": "Tap here",
        "${roomId! + "_newMessage"}": 0,
        "manager_newMessage": 0,
        "newMessage": 0,
        "lastMessageTime": messageTime,
        "name": PrefService.getString(PrefKeys.fullName),
        "isManager": "false",
        "fcmToken": fcmToken
      });
    }
    if (widget.isManager == false) {
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(mobileNo.toString())
          .get()
          .then((value) {
        count = value.data()!['${mobile! + "_newMessage"}'];
        count = count + 1;
        setState(() {
          print(count);
        });
      });
    } else {
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(widget.roomId)
          .get()
          .then((value) {
        count = value.data()!['manager_newMessage'];
        count = count + 1;
      });
    }

    roomDocument = await ChatRoomservice().getParticularRoom(roomId!);
    print(PrefService.getString(PrefKeys.managerID));
    MessageModel messageModel = MessageModel(
        content: content,
        sender: mobile,
        sendTime: messageTime.millisecondsSinceEpoch,
        type: type,
        senderName: PrefService.getString(PrefKeys.fullName),
        receiver: isManager == false
            ? PrefService.getString(PrefKeys.managerID)
            : roomId,
        mMessage: message);
    String? notificationBody;
    switch (type) {
      case "text":
        notificationBody = content;
        break;
      case "photo":
        notificationBody = "📷 Image";
        break;
      case "document":
        notificationBody = "📄 Document";
        break;
      case "music":
        notificationBody = "🎵 Music";
        break;
      case "video":
        notificationBody = "🎥 Video";
        break;
    }
    await getTokenList();

    SendNotificationModel notificationModel = SendNotificationModel(
      isGroup: false,
      title: username,
      body: notificationBody,
      fcmTokens: tokenList,
      roomId: roomId,
      id: "",
    );
    ChatRoomservice().sendMessage(messageModel, roomId!);

    ChatRoomservice().updateLastMessage({
      "lastMessage": notificationBody,
      "lastMessageTime": messageTime,
      "${isManager == true ? roomId : "manager" "_newMessage"}": 0,
      widget.isManager!
          ? "manager_newMessage"
          : "${mobileNo.toString() + "_newMessage"}": count
    }, roomId!);
    if (listScrollController.positions.isNotEmpty) {
      listScrollController.animateTo(0.0,
          duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    }

    if (isManager == false) {
      tokenList = tokenList!.toSet().toList();
      for (int i = 0; i < tokenList!.length; i++) {
        print("--------: ${tokenList!.length}");
        SendNotificationModel notificationModel1 = SendNotificationModel(
          isGroup: false,
          title: username,
          body: notificationBody,
          fcmToken: tokenList![i],
          roomId: roomId,
          id: "",
        );
        MessageService().sendNotification(notificationModel1);
      }
    } else {
      MessageService().sendNotification(notificationModel);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher',
              ),
            ));
      }
    });
    controller.clear();
    setState(() {});
  }

  getTokenList() async {
    if (isManager == true) {
      tokenList = [anotherFcmToken!];
    } else {
/*      Stream<QuerySnapshot> doc = await FirebaseFirestore.instance.collection("chatroom").snapshots();
      doc.forEach((element) {
        element.docs.forEach((el) {
          Map map = el.data() as Map;
          if (map['isManager'] == "true") {
            tokenList.add(map['fcmToken'].toString());
          }
        });
      });*/
    }
  }

  void onGalleryTap(BuildContext context) async {
    isAttachment = false;
    List<String> result =
        await MediaPicker.pickImages(quantity: 10, withCamera: false);
    uploadingMedia = true;
    uploadingMedia = false;
  }

  void onLongPressMessage(MessageModel messageModel, bool sender) async {}

  void onAudioTap() async {
    isAttachment = false;
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.audio, allowMultiple: false);
    if (result != null) {
      List<PlatformFile> fileList = result.files;
      uploadingMedia = true;
    }
  }

  void onDocumentTap() async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isDenied) {
      return null;
    }
    isAttachment = true;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: true,
      allowedExtensions: [
        'pdf',
        'xlsx',
        'xlsm',
        'xls',
        'ppt',
        'pptx',
        'doc',
        'docx',
        'txt',
        'text',
        'rtf',
        'zip',
      ],
    );
    if (result != null) {
      List<PlatformFile> fileList = result.files;
      uploadingMedia = true;
      uploadingMedia = false;
    }
  }

  void onVideoTap() async {
    isAttachment = false;
    uploadingMedia = true;
  }

  void onTapPress(MessageModel messageModel) {}

  @override
  void initState() {
    roomId = PrefService.getString(PrefKeys.uid);

    print(widget.roomId);
    // print(roomId);
    // checkVersion(context);
    callData();

    setInitiaCount();
    // getMessageCount();

    super.initState();
  }

  callData() async {
    await setData();
    roomIdExist();
  }

  setData() async {
    isManager = widget.isManager;
    mobile = PrefService.getString(PrefKeys.uid);
    roomId = mobile;
    anotherFcmToken = widget.fcmToken;

    fcmToken = await MessageService().getFcmToken();
    if (isManager == false) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      roomId = prefs.getString(MOBILE);
      username = prefs.getString(USERNAME);
      Stream<QuerySnapshot> doc =
          await FirebaseFirestore.instance.collection("chatroom").snapshots();
      doc.forEach((element) {
        element.docs.forEach((el) {
          Map map = el.data() as Map;
          if (map['isManager'] == "true") {
            tokenList!.add(map['fcmToken'].toString());
          }
        });
      });
    } else {
      setState(() {
        roomId = widget.roomId;
        username = widget.name;
      });
    }
    tokenList = tokenList!.toSet().toList();
    setState(() {});
  }

  @override
  void didChangeDependencies() {
    // checkVersion(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            isManager == false && widget.isFromProfile == false
                ? dashController.onItemTapped(0)
                : isManager == false && widget.isFromProfile == true
                    ? Get.back()
                    : Get.back();
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
        title: Text(
          PrefService.getString(PrefKeys.managerName),
          style: const TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 1,
        actions: [
          // InkWell(
          //   onTap: () async {
          //     // launch('tel://9409075553');
          //     const number = '+44 7570298692'; //set the number here
          //     await FlutterPhoneDirectCaller.callNumber(number);
          //   },
          //   child: Container(
          //       padding: const EdgeInsets.symmetric(vertical: 18),
          //       margin: const EdgeInsets.only(right: 16),
          //       child: Image.asset(
          //         AssetsRes.call,
          //         fit: BoxFit.fitHeight,
          //       )),
          // )
        ],
      ),
      body: (isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : doc!.exists == false
              ? Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AbsorbPointer(
                      absorbing: isAttachment,
                      child: Column(
                        children: [
                          const Expanded(
                            child: Center(
                              child: Text("Send a message"),
                            ),
                          ),
                          InputBottomBar(
                            msgController: controller,
                            onAttachment: onAttachmentTap,
                            onSend: onSend,
                            onCameraTap: onCameraTap,
                            onTextFieldChange: onTextFieldChange,
                            isTyping: isTyping,
                            focusNode: focusNode,
                            message: message,
                            clearReply: clearReply,
                          ),
                          SafeArea(
                              child: AnimatedOpacity(
                            opacity: isAttachment ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            child: isAttachment
                                ? AttachmentView(
                                    onDocumentTap: onDocumentTap,
                                    onVideoTap: onVideoTap,
                                    onGalleryTap: onGalleryTap,
                                    onAudioTap: onAudioTap)
                                : const SizedBox(),
                          )),
                          uploadingMedia
                              ? Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  color:
                                      const Color(0xFF696969).withOpacity(0.3),
                                  child: Column(
                                    children: [
                                      Platform.isIOS
                                          ? const CupertinoActivityIndicator()
                                          : const CircularProgressIndicator(),
                                      const Text("Uploading media")
                                    ],
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    )
                  ],
                )
              : Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    AbsorbPointer(
                      absorbing: isAttachment,
                      child: Column(
                        children: [
                          Expanded(
                              child: PaginateFirestore(
                            padding: const EdgeInsets.all(10.0),
                            query: ChatRoomservice().getMessages(
                                PrefService.getString(PrefKeys.uid), chatLimit),
                            itemBuilderType: PaginateBuilderType.listView,
                            isLive: true,
                            itemsPerPage: 10,
                            scrollController: listScrollController,
                            itemBuilder: (context, documentsnapshot, index) {
                              if (!listMessage.contains(documentsnapshot)) {
                                listMessage.add(documentsnapshot[index]
                                    as DocumentSnapshot<Object?>);
                              }
                              return MessageView(
                                index,
                                MessageModel.fromMap(
                                  documentsnapshot[index].data()
                                      as Map<String, dynamic>,
                                  documentsnapshot[index].id,
                                ),
                                selectedMessages,
                                onTapPress,
                                onLongPressMessage,
                                false,
                                false,
                                mobile!,
                              );
                            },
                            // emptyDisplay: Center(
                            //   child: Text("Send message"),
                            // ),
                            reverse: true,
                          )),
                          InputBottomBar(
                            msgController: controller,
                            onAttachment: onAttachmentTap,
                            onSend: onSend,
                            onCameraTap: onCameraTap,
                            onTextFieldChange: onTextFieldChange,
                            isTyping: isTyping,
                            focusNode: focusNode,
                            message: message,
                            clearReply: clearReply,
                          ),
                        ],
                      ),
                    ),
                    SafeArea(
                      child: AnimatedOpacity(
                        opacity: isAttachment ? 1 : 0,
                        duration: const Duration(milliseconds: 500),
                        child: isAttachment
                            ? AttachmentView(
                                onDocumentTap: onDocumentTap,
                                onVideoTap: onVideoTap,
                                onGalleryTap: onGalleryTap,
                                onAudioTap: onAudioTap)
                            : const SizedBox(),
                      ),
                    ),
                    uploadingMedia
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xFF696969).withOpacity(0.3),
                            child: Column(
                              children: [
                                Platform.isIOS
                                    ? const CupertinoActivityIndicator()
                                    : const CircularProgressIndicator(),
                                const Text("Uploading media")
                              ],
                            ),
                          )
                        : const SizedBox()
                  ],
                )),
    ); /*Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text("Odeva manager"),
      ),
      body:(isLoading ==true?Center(child: CircularProgressIndicator(),):   doc.exists==false?Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AbsorbPointer(
            absorbing: isAttachment,
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text("Send a message"),
                  ),
                ),
                InputBottomBar(
                  msgController: controller,
                  onAttachment: onAttachmentTap,
                  onSend: onSend,
                  onCameraTap: onCameraTap,
                  onTextFieldChange: onTextFieldChange,
                  isTyping: isTyping,
                  focusNode: focusNode,
                  message: message,
                  clearReply: clearReply,
                ),
                SafeArea(child: AnimatedOpacity(
                  opacity: isAttachment?1:0,
                  duration: Duration(milliseconds: 500),
                  child: isAttachment?AttachmentView(
                      onDocumentTap: onDocumentTap,
                      onVideoTap: onVideoTap,
                      onGalleryTap: onGalleryTap,
                      onAudioTap: onAudioTap):SizedBox(),
                )),
                uploadingMedia
                    ? Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  color: Color(0xFF696969).withOpacity(0.3),
                  child: Column(
                    children: [
                      Platform.isIOS
                          ? CupertinoActivityIndicator()
                          : CircularProgressIndicator(),
                      Text("Uploading media")
                    ],
                  ),
                )
                    : SizedBox()
              ],
            ),
          )

        ],
      ): Stack(
        alignment: Alignment.bottomCenter,
        children: [
          AbsorbPointer(
            absorbing: isAttachment,
            child: Column(
              children: [
                Expanded(
                    child: PaginateFirestore(
                      padding: EdgeInsets.all(10.0),
                      query: ChatRoomservice().getMessages(roomId, chatLimit),
                      itemBuilderType: PaginateBuilderType.listView,
                      isLive: true,
                      itemsPerPage: 10,
                      scrollController: listScrollController,
                      itemBuilder: (index, context, documentsnapshot) {
                        if (!listMessage.contains(documentsnapshot)) {
                          listMessage.add(documentsnapshot);
                        }
                        return MessageView(
                            index,
                            MessageModel.fromMap(
                              documentsnapshot.data(),
                              documentsnapshot.id,
                            ),
                            selectedMessages,
                            onTapPress,
                            onLongPressMessage,
                            false,
                            false);
                      },
                      emptyDisplay: Center(
                        child: Text("Send message"),
                      ),
                      reverse: true,
                    )),
                InputBottomBar(
                  msgController: controller,
                  onAttachment: onAttachmentTap,
                  onSend: onSend,
                  onCameraTap: onCameraTap,
                  onTextFieldChange: onTextFieldChange,
                  isTyping: isTyping,
                  focusNode: focusNode,
                  message: message,
                  clearReply: clearReply,
                ),

              ],
            ),
          ),
          SafeArea(
            child: AnimatedOpacity(
              opacity: isAttachment ? 1 : 0,
              duration: Duration(milliseconds: 500),
              child: isAttachment
                  ? AttachmentView(
                  onDocumentTap: onDocumentTap,
                  onVideoTap: onVideoTap,
                  onGalleryTap: onGalleryTap,
                  onAudioTap: onAudioTap)
                  : SizedBox(),
            ),
          ),
          uploadingMedia
              ? Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            color: Color(0xFF696969).withOpacity(0.3),
            child: Column(
              children: [
                Platform.isIOS
                    ? CupertinoActivityIndicator()
                    : CircularProgressIndicator(),
                Text("Uploading media")
              ],
            ),
          )
              : SizedBox()

        ],
      )),
    );*/
  }

  void onAttachmentTap() {
    focusNode.unfocus();
    isAttachment = !isAttachment;
    setState(() {});
  }

  void clearReply() {
    isReply = false;
    message = null;
  }
}

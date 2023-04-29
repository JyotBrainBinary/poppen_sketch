import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sketch/chat/model/message_model.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class InputBottomBar extends StatelessWidget {
  InputBottomBar(
      {this.message,
      this.msgController,
      this.isTyping,
      this.clearReply,
      this.onAttachment,
      this.onCameraTap,
      this.onSend,
      this.onTextFieldChange,
      this.focusNode});

  final MMessage? message;
  final TextEditingController? msgController;
  final bool? isTyping;
  final Function? clearReply;
  final VoidCallback? onAttachment;
  final VoidCallback? onCameraTap;
  final Function(MMessage)? onSend;
  final VoidCallback? onTextFieldChange;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: message == null
            ? Container(
                height: 60,
                padding: EdgeInsets.only(
                    left: Get.width * 0.048,
                    right: Get.width * 0.048,
                    top: 12,
                    bottom: 12),
                // margin: const EdgeInsets.only(left: 5, bottom: 5, right: 5),

                decoration: const BoxDecoration(
                    color: ColorRes.colorWhite,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 12,
                          offset: Offset(0, -4),
                          color: ColorRes.colorADB9CB)
                    ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        // margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.only(left: 5.7),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color:  ColorRes.color161823.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // onSend?.call(message ?? MMessage());
                              },
                              child: SizedBox(
                                height: 24.5,
                                width: 24.5,
                                // padding:
                                //     const EdgeInsets.only(left: 13, right: 11),
                                // decoration: BoxDecoration(
                                 
                                //   borderRadius: BorderRadius.circular(50),
                                // ),
                                child: 
                                Image.asset(AssetsRes.smile)
                                
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                style: const TextStyle(color: Colors.black),
                                maxLines: 5,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                minLines: 1,
                                controller: msgController,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Start Typing…",
                                  counterText: '',
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: ColorRes.color919BBF,
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 10, bottom: 10),
                                ),
                              ),
                            ),
                            /*                isTyping
                                ? Container()
                                : Container(
                              padding: EdgeInsets.only(left: 13, right: 5),
                              child: RotationTransition(
                                turns: AlwaysStoppedAnimation(135 / 360),
                                child: InkWell(
                                  onTap: () {
                                 //   onAttachment.call();
                                  },
                                  child: Icon(
                                    Icons.attachment,
                                    size: 28,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            isTyping
                                ? Container()
                                : Container(
                              padding: EdgeInsets.only(left: 5, right: 11),
                              child: InkWell(
                              //  onTap: onCameraTap,
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),*/
                            
                          ],
                        ),
                      ),
                    ),
                  
                  GestureDetector(
                              onTap: () {
                                onSend?.call(message ?? MMessage());
                              },
                              child: Container(

                                height: 32,
                                width: 32,
                              margin: EdgeInsets.only(left: Get.width *0.01),
                                // padding:
                                //     const EdgeInsets.only(left: 13, right: 11),
                                // decoration: BoxDecoration(
                                 
                                //   borderRadius: BorderRadius.circular(50),
                                // ),
                                child: 
                                Image.asset(AssetsRes.mic)
                                
                              ),
                            ),],
                ),
              )
            : Container(
                padding: const EdgeInsets.only(
                  left: 5,
                ),
                margin: const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: message!.mDataType == "photo" ? 7 : 16,
                          vertical: 6),
                      margin: const EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF200738),
                          ),
                          borderRadius: BorderRadius.circular(25),
                          color: const Color(0xFF200738).withOpacity(0.1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //ReplyMessage(message),
                          InkWell(
                            onTap: () {
                              clearReply!.call();
                            },
                            child: const Icon(
                              Icons.close_rounded,
                              color: Color(0xFF200738),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 5),
                          padding: const EdgeInsets.only(left: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFF200738),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextField(
                                style: const TextStyle(color: Colors.white),
                                maxLines: 5,
                                focusNode: focusNode,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                minLines: 1,
                                onChanged: (_) {
                                  onTextFieldChange!();
                                },
                                controller: msgController,
                                keyboardType: TextInputType.multiline,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type message",
                                  counterText: '',
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  contentPadding:
                                      EdgeInsets.only(left: 10, bottom: 5),
                                ),
                              ),
                              /*        isTyping
                                  ? Container()
                                  : Container(
                                      padding:
                                          EdgeInsets.only(left: 13, right: 5),
                                      child: RotationTransition(
                                        turns:
                                            AlwaysStoppedAnimation(135 / 360),
                                        child: InkWell(
                                          onTap: () {
                                            if (message != null)
                                              clearReply.call();
                                            else
                                              onAttachment.call();
                                          },
                                          child: Icon(
                                            Icons.attachment,
                                            size: 28,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                              isTyping
                                  ? Container()
                                  : Container(
                                      padding:
                                          EdgeInsets.only(left: 5, right: 11),
                                      child: InkWell(
                                        onTap: () {
                                          if (message != null)
                                            clearReply.call();
                                          else
                                            onCameraTap.call();
                                        },
                                        child: Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),*/
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (msgController!.text.trim().isNotEmpty) {
                              clearReply!.call();
                              onSend!.call(message!);
                            }
                          },
                          child: Container(
                            height: 50,
                            padding: const EdgeInsets.only(left: 13, right: 11),
                            decoration: BoxDecoration(
                              color: const Color(0xFF200738),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ));
  }
}

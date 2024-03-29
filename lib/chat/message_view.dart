import 'package:flutter/material.dart';
import 'package:sketch/chat/image_message.dart';
import 'package:sketch/chat/model/message_model.dart';
import 'package:sketch/chat/text_message.dart';


class MessageView extends StatelessWidget {
  final int index;
  final MessageModel message;
  //final Function(String, String) downloadDocument;
  final Function(MessageModel, bool) onLongPress;
  final Function(MessageModel) onTapPress;
  final List<MessageModel> selectedMessages;
  final bool forwardMode;
  final bool deleteMode;
  final String mobile;

  MessageView(
    this.index,
    this.message,
    //this.downloadDocument,
    this.selectedMessages,
    this.onTapPress,
    this.onLongPress,
    this.deleteMode,
    this.forwardMode,
      this.mobile
  );

  @override
  Widget build(BuildContext context) {
    final bool contains = selectedMessages
        .where((element) => element.id == message.id)
        .isNotEmpty;
    final bool sender = message.sender == mobile;
    return GestureDetector(
      onLongPress: forwardMode || deleteMode
          ? null
          : () {
              onLongPress.call(message, sender);
            },
      onTap: () {
        if (forwardMode) {
          onTapPress.call(message);
        } else if (deleteMode) {
          if (sender) {
            onTapPress.call(message);
          }
        }
      },
      child: Stack(
        alignment: sender ? Alignment.centerRight : Alignment.centerLeft,
        children: [
          message.type == "text"
              ? TextMessage(message, sender)
              : message.type == "photo"
                  ? ImageMessage(message, forwardMode || deleteMode, sender)
                  : Container()/*DocumentMessage(
                      message,
                      downloadDocument,
                      sender,
                      forwardMode || deleteMode,
                    )*/,
          contains
              ? Positioned.fill(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: const BoxConstraints(
                      minHeight: 30,
                    ),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: sender
                          ? const BorderRadius.only(
                              topRight: Radius.circular(12),
                              bottomRight: Radius.circular(12))
                          : const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12)),
                      color: Colors.green.withOpacity(0.3),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}

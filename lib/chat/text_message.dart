import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:sketch/chat/model/message_model.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

import 'package:url_launcher/url_launcher.dart';

class TextMessage extends StatelessWidget {
  final MessageModel message;
  final bool sender;

  TextMessage(this.message, this.sender);

  @override
  Widget build(BuildContext context) {
    return message.mMessage != null && message.mMessage!.mType == Type.reply
        ? Container(
            decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(AssetsRes.chatBack), fit: BoxFit.fill)),
            margin: EdgeInsets.only(
              left: sender ? 10 : 0,
              right: sender ? 0 : 10,
              bottom: 10,
            ),
            child: Column(
              crossAxisAlignment:
                  sender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: <Widget>[
                /*            Container(
                  width: 220,
                  constraints: BoxConstraints(
                    maxHeight: 200,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ReplyMessage(message.mMessage),
                ),*/
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: AssetImage(AssetsRes.chatBack),
                          fit: BoxFit.fill)),
                  width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Linkify(
                          onOpen: (link) async {
                            if (await canLaunch(link.url)) {
                              await launch(link.url);
                            }
                          },
                          text: message.content ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          linkStyle: const TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        hFormat(DateTime.fromMillisecondsSinceEpoch(
                            message.sendTime ?? 0)),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width / 1.3,
            ),
          )
        : Stack(
          // crossAxisAlignment:sender? CrossAxisAlignment.end :CrossAxisAlignment.start,
            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 1.3,
                ),
                decoration: BoxDecoration(
                  color: sender ? ColorRes.color161823 : ColorRes.colorF4F4F4,
                  //  image: DecorationImage(
                  //       image: AssetImage(AssetsRes.chatBack), fit: BoxFit.fill,),
                  borderRadius: BorderRadius.circular(
                      message.content.toString().length >= 50 ? 10 : 12),
                ),
                margin: EdgeInsets.only(
                  left: sender ? 10 : 0,
                  right: sender ? 0 : 10,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Linkify(
                        onOpen: (link) async {
                          if (await canLaunch(link.url)) {
                            await launch(link.url);
                          }
                        },
                        text: message.content ?? "",
                        style: TextStyle(
                          color: sender
                              ? ColorRes.colorF4F4F4
                              : ColorRes.color161823,
                          fontSize: 14,
                        ),
                        linkStyle: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontSize: 14),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      margin: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        hFormat(DateTime.fromMillisecondsSinceEpoch(
                            message.sendTime ?? 0)),
                        style: TextStyle(
                          color: sender
                              ? ColorRes.colorF4F4F4.withOpacity(0.8)
                              : ColorRes.color161823.withOpacity(0.8),
                          fontSize: 12,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            sender?  Positioned(
                bottom: 6,
               right: 0,
                child: Row(mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      AssetsRes.right,height: 8,
                      color: ColorRes.color161823,
                    ),
                  ],
                ),
              ):Positioned(
                bottom: 6,
               left: 0,
                child: Row(mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      AssetsRes.left,height: 8,
                      color: ColorRes.colorF4F4F4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,)
            ],
          );
  }
}

String hFormat(DateTime date) {
  if (DateTime.now().difference(date).inDays == 1) {
    return "yesterday";
  } else if (DateTime.now().difference(date).inDays > 364) {
    return DateFormat('dd-MM-yyyy').format(date);
  } else if (DateTime.now().difference(date).inDays > 1) {
    return DateFormat('dd-MM').format(date);
  } else {
    return DateFormat('hh:mm a').format(date);
  }
}

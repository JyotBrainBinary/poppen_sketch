import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sketch/chat/model/message_model.dart';
import 'package:sketch/chat/text_message.dart';

class ImageMessage extends StatelessWidget {
  final MessageModel message;
  final bool selectionMode;
  final bool sender;

  const ImageMessage(this.message, this.selectionMode, this.sender, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: sender ? 10 : 0,
        right: sender ? 0 : 10,
        bottom: 10,
      ),
      height: 200,
      width: 200,
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: selectionMode
                ? null
                : () async {
                 /*   await Get.dialog(
                      Dialog(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: message.content,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      CircularProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ],
                        ),
                      ),
                    );*/
                  },
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              child: CachedNetworkImage(
                imageUrl: message.content ??'',
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
                progressIndicatorBuilder: (context, url, downloadProgress) {
                  return Padding(
                    padding: const EdgeInsets.all(80),
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  );
                },
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(right: 10, bottom: 5),
              child: Text(
                hFormat(DateTime.fromMillisecondsSinceEpoch(message.sendTime??0)),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 12,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

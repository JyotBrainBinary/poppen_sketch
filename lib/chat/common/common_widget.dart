import 'package:flutter/material.dart';
class AttachmentView extends StatelessWidget {
  final Function? onDocumentTap;
  final Function? onVideoTap;
  final Function? onGalleryTap;
  final Function? onAudioTap;

  AttachmentView({
    @required this.onDocumentTap,
    @required this.onVideoTap,
    @required this.onGalleryTap,
    @required this.onAudioTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      height: 90,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
        bottom: 60,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          iconTile(
            text:"document",
            icon: Icons.insert_drive_file,
            onTap: onDocumentTap!(),
          ),
          iconTile(
            text: "video",
            icon: Icons.videocam_rounded,
            onTap: onVideoTap!(),
          ),
          iconTile(
            text: "gallery",
            icon: Icons.image_rounded,
            onTap: onGalleryTap!(),
          ),
          iconTile(
            text: "audio",
            icon: Icons.headset_mic_rounded,
            onTap: onAudioTap!(),
          ),
        ],
      ),
    );
  }

  Widget iconTile({
    IconData? icon,
    String? text,
    VoidCallback? onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Colors.green,
            child: Icon(
              icon,
              color: Colors.white,
              size: 21,
            ),
          ),
        ),
        //verticalSpaceTiny,
        Text(
          text?? '',
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}


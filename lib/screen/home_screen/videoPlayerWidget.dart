
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  String videoUrl;
   VideoPlayerWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  late VideoPlayerController _controller;

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });

    _chewieController = ChewieController(
      autoInitialize: true,
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
      aspectRatio: 4 / 3,
      allowPlaybackSpeedChanging: false,
    );


  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.998,
      width: Get.width ,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          VideoPlayer(_controller),
          Center(
            child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_controller.value.isPlaying) {
                      _controller.pause();
                    } else {
                      // If the video is paused, play it.
                      _controller.play();
                    }
                  });
                },
                child: _controller.value.isPlaying
                    ? const Icon(
                  Icons.pause,
                  size: 30,
                  color: Colors.white,
                )
                    : const Icon(
                  Icons.play_arrow,
                  size: 30,
                  color: Colors.white,
                )),
          ),

        ],
      ),
    );
  }


  @override
  void dispose() {
    _controller.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

}

// ignore_for_file: library_private_types_in_public_api

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/color_res.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final String url;
  const VideoPreview(this.url, {super.key});

  @override
  _VideoPreviewState createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  late ChewieController chewieController;
  bool isPlaying = false;
  double progressValue = 0;
  bool isVideoLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    // _controller = VideoPlayerController.contentUri(Uri.parse(widget.url));
    chewieController = ChewieController(
      videoPlayerController: _controller,
      aspectRatio: 16 / 9,
      errorBuilder: (context, errorMessage) {
        return const Text(
          "video error",
          style: TextStyle(fontSize: 20),
        );
      },
      showControls: true,
      autoInitialize: true,
      looping: false,
      autoPlay: true,
      hideControlsTimer: const Duration(seconds: 2),
      materialProgressColors: ChewieProgressColors(
        playedColor: ColorRes.color8401FF,
        handleColor: ColorRes.colorWhite,
        backgroundColor: ColorRes.color8401FF.withOpacity(.3),
      ),
      allowPlaybackSpeedChanging: false,
    );
    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        if (isVideoLoading && !_controller.value.isPlaying) {
          setState(() {
            isVideoLoading = false;
          });
        }
      }
    });
    /*_controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        final duration = _controller.value.duration;
        final position = _controller.value.position;
        if (duration != null && position != null) {
          setState(() {
            progressValue = position.inMilliseconds.toDouble() /
                duration.inMilliseconds.toDouble();
          });
        }
      })
      ..setLooping(true)
      ..initialize().then((_) => setState(() {}));*/
    /*_controller = VideoPlayerController.network(
        "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");
    //_controller = VideoPlayerController.asset("videos/sample_video.mp4");
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);*/
  }

  @override
  void dispose() {
    _controller.dispose();
    chewieController.dispose();
    super.dispose();
  }

  void playPause() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _controller.play();
      } else {
        _controller.pause();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.close,
                      size: 25,
                      color: ColorRes.colorWhite,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Stack(
                    children: [
                      isVideoLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                  color: ColorRes.color8401FF),
                            )
                          : AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Center(
                                  child: Chewie(controller: chewieController)),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // FutureBuilder(
      //   future: _initializeVideoPlayerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       return Center(
      //         child: AspectRatio(
      //           aspectRatio: _controller.value.aspectRatio,
      //           child: VideoPlayer(_controller),
      //         ),
      //       );
      //     } else {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_controller.value.isPlaying) {
      //         _controller.pause();
      //       } else {
      //         _controller.play();
      //       }
      //     });
      //   },
      //   child:
      //   Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
      // ),
      // GestureDetector(
      //   onTap: () {
      //     if (_controller.value.isPlaying) {
      //       _controller.pause();
      //     } else {
      //       _controller.play();
      //     }
      //   },
      //   child: Hero(
      //     tag: widget.url,
      //     child: AspectRatio(
      //       aspectRatio: _controller.value.aspectRatio,
      //       child: Center(
      //         child: _controller.value.isInitialized
      //             ? Stack(
      //                 alignment: Alignment.bottomCenter,
      //                 children: [
      //                   AspectRatio(
      //                     aspectRatio: _controller.value.aspectRatio,
      //                     child: VideoPlayer(_controller),
      //                   ),
      //                   Padding(
      //                     padding: EdgeInsets.all(16),
      //                     child: LinearProgressIndicator(
      //                       value: progressValue,
      //                     ),
      //                   ),
      //                   IconButton(
      //                     icon: Icon(
      //                       isPlaying ? Icons.pause : Icons.play_arrow,
      //                       size: 32,
      //                     ),
      //                     onPressed: playPause,
      //                   ),
      //                 ],
      //               )
      //             : CircularProgressIndicator(),
      //       ),
      //       // _controller.value.isInitialized
      //       //     ? VideoPlayer(_controller)
      //       //     : Container(), // Placeholder until the video is initialized
      //     ),
      //   ),
      // ),
    );
  }
}

/*

import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final bool showPlayPause;
  final bool autoPlay;
   VideoPlayerWidget({Key? key, required this.videoUrl, required this.showPlayPause, required this.autoPlay}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  late VideoPlayerController _controller;

  bool isPlay = false;
  bool isLoading = false;
  bool isError = false;

  bool isPlayPauseTimerExceeded = false;

  dynamic timer;

  ChewieController? _chewieController;

  @override
  void initState() {
    super.initState();

    if (widget.showPlayPause) {
      playPauseIconTimer();
    }


    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        if (widget.autoPlay) {
          _controller.play();
        }
      }).catchError((e) {
        setState(() {
          isError = true;
        });
      }).onError((error, stackTrace) {
        setState(() {
          isError = true;
        });
      });;


    _chewieController = ChewieController(
      autoInitialize: true,
      videoPlayerController: _controller,
      autoPlay: false,
      looping: true,
      aspectRatio: 4 / 3,
      allowPlaybackSpeedChanging: false,
    );


  }

  playPauseIconTimer() {
    setState(() {
      isPlayPauseTimerExceeded = false;
    });
    timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isPlayPauseTimerExceeded = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * 0.998,
      width: Get.width ,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          (isError)? Center(child: CircularProgressIndicator(),)  : VideoPlayer(_controller),
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
    //controller.pause();
    _chewieController!.dispose();
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

}
*/


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';


class VideoPlayerWidget extends StatefulWidget {
  final dynamic video;
  final String videoFrom;
  final bool autoPlay;
  final bool showPlayPause;
  final bool showVideoIcon;
  final bool touchToSeePlayPause;

  const VideoPlayerWidget(
      {Key? key,
        required this.video,
        this.videoFrom = 'network',
        this.autoPlay = false,
        this.showPlayPause = true,
        this.showVideoIcon = false,
        this.touchToSeePlayPause = true})
      : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  // late CachedVideoPlayerController videoPlayerController;
  late VideoPlayerController videoPlayerController;
  bool isPlay = false;
  bool isLoading = false;
  bool isPlayPauseTimerExceeded = false;

  dynamic timer;

  @override
  void initState() {
    super.initState();
    if (widget.showPlayPause) {
      playPauseIconTimer();
    }

    setState(() {
      isLoading = true;
    });

    // load and play video from url
    videoPlayerController = VideoPlayerController.network(widget.video)
      ..initialize().then((value) {
        setState(() {
          isLoading = false;
        });
        videoPlayerController.setVolume(1);
        if (widget.autoPlay) {
          videoPlayerController.play();
        }
      });
  }

  playPauseIconTimer() {
    setState(() {
      isPlayPauseTimerExceeded = false;
    });
    timer = Timer(const Duration(seconds: 3), () {
      setState(() {
        isPlayPauseTimerExceeded = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('Dispose Video Contoller');
    videoPlayerController.dispose();
    if (timer != null) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(
      child: CircularProgressIndicator(),
    )
        : AspectRatio(
        aspectRatio: 16 / 22,
        child: !widget.touchToSeePlayPause
            ? videoContainer()
            : GestureDetector(
            onTap: () => playPauseIconTimer(),
            child: videoContainer()));
  }

  Widget videoContainer() {
    return Stack(
      children: [
        VideoPlayer(videoPlayerController),
        if ((widget.showPlayPause && !widget.touchToSeePlayPause) ||
            (!isPlayPauseTimerExceeded && widget.touchToSeePlayPause))
          Align(
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                if (isPlay) {
                  videoPlayerController.pause();
                } else {
                  videoPlayerController.play();
                }

                setState(() {
                  isPlay = !isPlay;
                });
              },
              icon: Icon(
                isPlay ? Icons.pause_circle : Icons.play_circle,
                size: 32,
                color: Colors.white,
              ),
            ),
          ),
        if (widget.showVideoIcon)
          const Positioned(
            right: 5,
            top: 5,
            child: Icon(
              Icons.ondemand_video_rounded,
              color: Colors.white,
              size: 15,
            ),
          )
      ],
    );
  }
}
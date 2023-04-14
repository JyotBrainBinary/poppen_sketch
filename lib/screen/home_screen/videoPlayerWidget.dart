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
import 'package:get/get.dart';
import 'package:image_stack/image_stack.dart';
import 'package:sketch/screen/common/widget/textStyle.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';
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

  HomeController homeController = Get.put(HomeController());

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
        ? const Center(
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
      alignment: Alignment.topCenter,
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
          ),
        onVideoUi(),
      ],
    );
  }

  Widget onVideoUi(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: Get.height * 0.12),
          /// ----------- top 2 ------------
          Image.asset(AssetsRes.restaurantLogo, height: Get.height * 0.1,),
          const SizedBox(height: 5),
          Container(
            height: Get.height * 0.045,
            width: Get.width * 0.4,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: ColorRes.colorWhite,
              boxShadow: [
                BoxShadow(
                  color: ColorRes.colorBlack.withOpacity(0.2),
                  blurRadius: 13.0,
                  spreadRadius: 0.13,
                  // offset: const Offset(1.0, 5.5),
                )
              ],
            ),
            child: Text("Republiq Bar & Grill", style: regular(color: ColorRes.colorBlack),),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.04,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.color161823.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.02,
                      width: Get.width * 0.035,
                      color: ColorRes.color4A48F1,
                    ),
                    const SizedBox(width: 10,),
                    Text("Restaurant", style: regular(fontSize: 12),),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: Get.height * 0.04,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.color161823.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.02,
                      width: Get.width * 0.035,
                      color: ColorRes.colorEA4258,
                    ),
                    const SizedBox(width: 10,),
                    Text("Date Night", style: regular(fontSize: 12),),
                  ],
                ),
              ),
              const SizedBox(width: 5),
              Container(
                height: Get.height * 0.04,
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: ColorRes.color161823.withOpacity(0.3),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: Get.height * 0.02,
                      width: Get.width * 0.035,
                      color: ColorRes.colorWhite,
                    ),
                    const SizedBox(width: 10,),
                    Text("Bar", style: regular(fontSize: 12),),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          /// ----------- bottom -----------
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///visit
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ImageStack(
                        imageList: homeController.visitsPeopleImage
                            .map((e) => e.toString())
                            .toList(),
                        totalCount: 3,
                        // If larger than images.length, will show extra empty circle
                        imageRadius: 32,
                        // Radius of each images
                        imageCount: 3,
                        // Maximum number of images to be shown in stack
                        imageBorderWidth: 0,

                        showTotalCount: false,
                        // Border width around the images
                      ),
                      const SizedBox(width: 5),
                      Text("+6k Visits", style: regularShaow())
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        height: Get.height * 0.03,
                        width: Get.width * 0.22,
                        color: ColorRes.colorEFC744,
                        child: Row(
                          children: List.generate(4, (index) => Row(
                            children: [
                              Container(
                                width: 1,
                                height: 20,
                                color: Colors.grey,
                              ),
                              SizedBox(width: Get.width * 0.05,)
                            ],
                          ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text("(55)", style: regularShaow())
                    ],
                  ),
                ],
              ),

              ///3 icon
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                        ),
                        child:  Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorRes.colorBlack.withOpacity(0.2),
                                  blurRadius: 13.0,
                                  spreadRadius: 0.01,
                                  // offset: const Offset(1.0, 5.5),
                                )
                              ],
                            image: DecorationImage(
                              image: AssetImage(AssetsRes.message),
                              scale: 4.5,
                            )
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("1.5k", style: regularShaow(),),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                        ),
                        child:  Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorRes.colorBlack.withOpacity(0.2),
                                  blurRadius: 13.0,
                                  spreadRadius: 0.01,
                                  // offset: const Offset(1.0, 5.5),
                                )
                              ],
                              image: DecorationImage(
                                image: AssetImage(AssetsRes.share),
                                scale: 4.5,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("SHARE", style: regularShaow(),),
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                        ),
                        child:  Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: ColorRes.colorBlack.withOpacity(0.2),
                                  blurRadius: 13.0,
                                  // offset: const Offset(1.0, 5.5),
                                )
                              ],
                              image: DecorationImage(
                                image: AssetImage(AssetsRes.star),
                                scale: 4.5,
                              )
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text("250", style: regularShaow(),),
                    ],
                  ),

                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

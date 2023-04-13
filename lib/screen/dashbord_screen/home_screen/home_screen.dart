
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/dashbord_screen/home_screen/videoPlayerWidget.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List videoUrl = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  ];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: SizedBox(
          height: Get.height * 0.998,
          width: Get.width ,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: videoUrl.length,
            itemBuilder: (context, index){
          return VideoPlayerWidget(videoUrl: videoUrl[index]);
        })
      ),
    );
  }


}





/*class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List videoUrl = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4'
  ];

  int index = 0;

  late VideoPlayerController _controller;

  ChewieController? _chewieController;

  ScrollController scrollController = ScrollController();

  video(){
    _controller = VideoPlayerController.network(
        videoUrl[index])
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
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void initState() {
    super.initState();
    video();

    scrollController.addListener(() {

      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        index = 1;
        setState(() {
          video();
        });
         //index++;
      } else if(scrollController.position.pixels == scrollController.position.minScrollExtent){
        index = 0;
        setState(() {
          video();
        });
      }

    });

  }




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.5),
      body: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
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
            ),
            SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

}*/
/*class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  List<VideoPlayerController> _controllers = [];

  List<String> videoUrl = [
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4",
    "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4",
  ];


  @override
  void initState() {
    super.initState();
    videoUrl.forEach((element) {
      _controllers.add(VideoPlayerController.network(element));
    });
  }

  void _playVideos() {
    _controllers.forEach((controller) {
      controller
        ..initialize().then((_) {
          setState(() {});
        });
      controller.value.isPlaying ? controller.pause() : controller.play();
    });
  }

  bool isVideosPlaying() {
    for (VideoPlayerController controller in _controllers) {
      if (controller.value.isPlaying) {
        return true;
      }
    }
    return false;
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SizedBox(
        height: Get.height * 0.998,
        width: Get.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: videoUrl.length,
          itemBuilder: (ctx, index) {
            VideoPlayerController controller = _controllers[index];
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                VideoPlayer(controller),
                Center(
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _playVideos();
                        });
                      },
                      child: isVideosPlaying()
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
            );
          },

        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllers.forEach((controller) {
      controller.dispose();
    });
  }

}*/


import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sketch/api_call/favourite_api_call.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/favourite_list_model.dart';

import 'package:sketch/utils/assets_res.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';

class FavouritesController extends GetxController {
  RxBool isLoading = false.obs;
  FavouriteListModel favouriteListModel = FavouriteListModel();
  final List<String> itemsList = [
    'https://picsum.photos/id/1015/400/400',
    'https://picsum.photos/id/1020/400/400',
    'https://picsum.photos/id/1024/400/400',
    'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
    'https://picsum.photos/id/1035/400/400',
    'https://picsum.photos/id/1040/400/400',
    'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
  ];
  @override
  void onInit() {
    // TODO: implement onInit
    // generateThumbnail().then((value) {
    //   print("====================${value}");
    // });
    callFavouriteListApi();
    super.onInit();
  }

  callFavouriteListApi() {
    try {
      isLoading.value = true;
      FavouriteApi.favouriteList().then((value) {
        if (value != null) {
          favouriteListModel = value;
          isLoading.value = false;

          update(["id"]);
          debugPrint("==========: ${favouriteListModel.data!.length}");
        }
      });
    } catch (e) {
      isLoading.value = false;
      errorToast(e.toString());
    }
  }




  Future<void> openMap({required String lat,required String long}) async {
    final String googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$long';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl),
      mode: LaunchMode.externalApplication);
    } else {
      print("----------- fail --------");
      throw 'Could not open the map.';
    }
  }


  // Future<File> generateThumbnail() async {
  //   final String? _path = await VideoThumbnail.thumbnailFile(
  //     video: 'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4',
  //     thumbnailPath: (await getTemporaryDirectory()).path, /// path_provider
  //     imageFormat: ImageFormat.PNG,
  //     maxHeight: 50,
  //     quality: 50,
  //   );
  //   print("--------- ${_path}");
  //   return File(_path!);
  //
  // }



  List favouriteList = [
    {
      "dataList": [
        {"image": AssetsRes.message, "text": "Restaurant"},
        {"image": AssetsRes.message, "text": "Date Night"},
        {"image": AssetsRes.message, "text": "Bar"}
      ]
    },
    {
      "dataList": [
        {"image": AssetsRes.message, "text": "Restaurant"},
        {"image": AssetsRes.message, "text": "Date Night"},
        {"image": AssetsRes.message, "text": "Bar"}
      ]
    },
    {
      "dataList": [
        {"image": AssetsRes.message, "text": "Restaurant"},
        {"image": AssetsRes.message, "text": "Date Night"}
      ]
    },
  ];
}

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sketch/api_call/view_business_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/view_business_model.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ProfileController extends GetxController {
  // PageController pageController = PageController();
  RxBool isLoading = true.obs;
  var viewBusinessModel = ViewBusinessModel().obs;
  int curr = 0;
  bool isGalleryTab = true;

  @override
  Future<void> onInit() async {
    await generateThumb().then((value) {
      debugPrint("===========: $value");
    });
    super.onInit();
  }

  Future<String?> generateThumb() async {
    try {
      final fileName = await VideoThumbnail.thumbnailFile(
        video:
            "https://poppen-storage.s3.amazonaws.com/eb7302d72ac243289fa21b700_1920_1080.mp4",
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.WEBP,
        maxHeight:
            64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
        quality: 75,
      );
      debugPrint("----------: $fileName");
      return fileName;
    } catch (e) {
      debugPrint("----------: $e");
    }
    return null;
  }
//   @override
//   Future<void> onInit() async{
// String id = PrefService.getString(PrefKeys.registerToken).tr.toString();
//     print("ID:  ===============  $id");
//     // callViewBusinessApi(id:id);
//     super.onInit();
//   }

  // List<Widget> pageViewList = <Widget>[
  //   FeedScreen(),
  //   DetailScreen(),
  //   // ReviewsScreen(),
  //
  // ];

  void changeTab() {
    isGalleryTab = !isGalleryTab;
    update(["tab"]);
  }

  List feedImage = [
    AssetsRes.image1,
    AssetsRes.image2,
    AssetsRes.image3,
    AssetsRes.image4,
    AssetsRes.image5,
    AssetsRes.image6,
    AssetsRes.image1,
    AssetsRes.image2,
    AssetsRes.image3
  ];

  List weekList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  List weekTimeList = [
    "5 - 10PM",
    "5 - 10PM",
    "5 - 10PM",
    "5 - 10PM",
    "5 - 12AM",
    "12 - 12AM",
    "12 - 10PM"
  ];

  void callViewBusinessApi({required String id}) {
    try {
      isLoading.value = true;

      ViewBusinessApi.viewBusinessApiCall(id: id).then((value) {
        if (value != null) {
          viewBusinessModel.value = value;
          isLoading.value = false;

          update(["id"]);
// update(["tab"]);
          print(
              "viewBusinessList  --------->  ${viewBusinessModel.value.status}");
        } else {
          isLoading.value = false;
          // errorToast(StringRes.errText);
        }
      });
      // update(["id"]);
    } catch (e) {
      print("error: =======>> $e");
      isLoading.value = false;
      errorToast(StringRes.errText);
      rethrow;
    }
  }
}

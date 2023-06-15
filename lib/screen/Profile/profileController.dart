import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/view_business_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/view_business_model.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';

class ProfileController extends GetxController {
  // PageController pageController = PageController();
  RxBool isLoading = true.obs;
  var viewBusinessModel = ViewBusinessModel().obs;
  int curr = 0;
  bool isGalleryTab = true;
  List galleryList = [];

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

      ViewBusinessApi.viewBusinessApiCall(id: id).then((value) async {
        if (value != null) {
          viewBusinessModel.value = value;
          isLoading.value = false;
          // await generateThumb();
          update(["id"]);
// update(["tab"]);
          debugPrint(
              "viewBusinessList  --------->  ${viewBusinessModel.value.status}");
        } else {
          isLoading.value = false;
          // errorToast(StringRes.errText);
        }
      });
      // update(["id"]);
    } catch (e) {
      debugPrint("error: =======>> $e");
      isLoading.value = false;
      errorToast(StringRes.errText);
      rethrow;
    }
  }

  // Future generateThumb() async {
  //   try {
  //     viewBusinessModel.value.data!.galleryList!.forEach((element) async {
  //       if (element.endsWith(".mp4")) {
  //         final fileName = await VideoThumbnail.thumbnailFile(
  //           video: element,
  //           thumbnailPath: (await getTemporaryDirectory()).path,
  //           imageFormat: ImageFormat.WEBP,
  //           maxHeight:
  //               64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
  //           quality: 75,
  //         );
  //         debugPrint("=========: $fileName");
  //         galleryList.add(fileName);
  //       } else {
  //         galleryList.add(element);
  //         print("length: -----+======${galleryList.length}");
  //       }
  //     });
  //
  //     debugPrint("thumb list----------: $galleryList");
  //     // return galleryList;
  //   } catch (e) {
  //     debugPrint("----------: $e");
  //     galleryList.clear();
  //     galleryList = viewBusinessModel.value.data!.galleryList!;
  //     update(["id"]);
  //   }
  //   // return null;
  // }
}

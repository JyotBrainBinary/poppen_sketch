import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:sketch/api_call/view_business_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/view_business_model.dart';
import 'package:sketch/screen/Profile/widget/details_screen.dart';
import 'package:sketch/screen/Profile/widget/feed_screen.dart';
import 'package:sketch/screen/Profile/widget/reviews_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/pref_key.dart';

class ProfileController extends GetxController {
  // PageController pageController = PageController();
  RxBool isLoading = true.obs;
  var viewBusinessModel = ViewBusinessModel().obs;
  int curr = 0;
  bool isGalleryTab = true;

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
        }
        else{
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

import 'package:get/get.dart';
import 'package:sketch/api_call/favourite_api_call.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/favourite_list_model.dart';

import 'package:sketch/utils/assets_res.dart';

class FavouritesController extends GetxController {
  RxBool isLoading = false.obs;
  FavouriteListModel favouriteListModel = FavouriteListModel();

  @override
  void onInit() {
    // TODO: implement onInit

    callFavouriteListApi();
    super.onInit();
  }

  callFavouriteListApi() {
    try {
      FavouriteApi.favouriteList().then((value) {
        if (value != null) {
          favouriteListModel = value;
          isLoading.value = false;
          print("object value :     ${favouriteListModel.data![0].category}");
          update(["id"]);
        }
      });
    } catch (e) {
      isLoading.value = false;
      errorToast(e.toString());
    }
  }

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

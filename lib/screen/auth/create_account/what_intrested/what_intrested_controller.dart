import 'package:get/get.dart';
import 'package:sketch/api_call/intrest_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/screen/auth/login/login_screen.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/utils/StringRes.dart';

class WhatIntrestedController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    getIntrest();
    super.onInit();
  }


  List intrestedList = [
    "Restaurants",
    "Bars",
    "Date Ideas",
    "Restaurants",
    "Bars",
    "Date Ideas",
    "Restaurants",
    "Bars",
    "Date Ideas"
  ];

  List selectedIntrestList = [];
  RxBool loading = false.obs;
  var intrestListModel = IntrestListModel().obs;

  void selectCategory({required dynamic item}) {
    if (selectedIntrestList.contains(item)) {
      selectedIntrestList.remove(item);
      update(["id"]);
    } else {
      selectedIntrestList.add(item);
      update(["id"]);
    }
    update(["id"]);
  }

  getIntrest() {
    try {
      loading.value = true;
      IntrestApi.getInterestList().then((value) {
        if (value != null) {
          if (value.status == true) {
            intrestListModel.value = value;
          loading.value = false;
          }
          loading.value = false;
          // flutterToast("Intersted added successfully");
          // Get.to(() => DashBoardScreen());
        } else {
          loading.value = false;
          errorToast(StringRes.errText);
        }
      });
    } catch (e) {
      loading.value = false;
      errorToast(StringRes.errText);
      rethrow;
    }
  }

  validateIntrest() {
    try {
      loading.value = true;
      IntrestApi.intrestedApi(intersted: ["Restaurant", "Club", "Bar"])
          .then((value) {
        if (value == true) {
          loading.value = false;
          // flutterToast("Intersted added successfully");

          Get.to(() => DashBoardScreen());
        } else {
          loading.value = false;
          errorToast(StringRes.errText);
        }
      });
    } catch (e) {
      loading.value = false;
      errorToast(StringRes.errText);
      rethrow;
    }
  }
}

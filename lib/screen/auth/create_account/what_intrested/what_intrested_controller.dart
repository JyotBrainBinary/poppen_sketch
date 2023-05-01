import 'package:get/get.dart';
import 'package:sketch/api_call/intrest_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/pref_key.dart';

class WhatIntrestedController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    getIntrest();
    super.onInit();
  }

  // List intrestedList = [
  //   "Restaurants",
  //   "Bars",
  //   "Date Ideas",
  //   "Restaurants",
  //   "Bars",
  //   "Date Ideas",
  //   "Restaurants",
  //   "Bars",
  //   "Date Ideas"
  // ];

  List<Datum> selectedIntrestList = [];
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
            print("intrestModel: res: ---------${intrestListModel.value}");
            loading.value = false;
            update(["id"]);
          }
          loading.value = false;
          update(["id"]);
          // flutterToast("Intersted added successfully");
          // Get.to(() => DashBoardScreen());
        } else {
          loading.value = false;
          errorToast(StringRes.errText);
          update(["id"]);
        }
      });
    } catch (e) {
      loading.value = false;
      errorToast(StringRes.errText);
      update(["id"]);
      rethrow;
    }
  }

  validateIntrest({List<String>? list}) {
    List<String> idList = [];
    selectedIntrestList.forEach((element) {
      idList.add(element.id.toString());
    });
    String id = idList.join(",");
    print("-=-=-==-==   $id");

    try {
      loading.value = true;
      IntrestApi.intrestedApi(id: id).then((value) async {
        if (value == true) {
          await PrefService.setValue(PrefKeys.login, true);
          loading.value = false;
          // flutterToast("Intersted added successfully");

          Get.offAll(() => DashBoardScreen());
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

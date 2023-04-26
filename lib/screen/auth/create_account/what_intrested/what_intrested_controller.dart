import 'package:get/get.dart';
import 'package:sketch/api_call/what_intrested_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/screen/auth/login/login_screen.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/utils/StringRes.dart';

class WhatIntrestedController extends GetxController{


  List intrestedList = ["Restaurants", "Bars", "Date Ideas","Restaurants", "Bars", "Date Ideas","Restaurants", "Bars", "Date Ideas"];

  List selectedIntrestList = [];
  RxBool loading = false.obs;

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


  validateIntrest(){
    try{
      loading.value = true;
      WhatIntrestedApi.intrestedApi(intersted: ["Restaurant","Club","Bar"]).then((value) {
        if(value == true)
        {
          loading.value = false;
          flutterToast("Intersted added successfully");

          Get.to(() => DashBoardScreen());
        }
        else{
          loading.value = false;
          errorToast(StringRes.errText);
        }
      });
    }
    catch(e)
    {
      loading.value = false;
      errorToast(StringRes.errText);
      rethrow;
    }

  }

}
import 'package:get/get.dart';
import 'package:sketch/api_call/business_list_api.dart';
import 'package:sketch/api_call/intrest_api.dart';
import 'package:sketch/model/business_list_model.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

import '../../common/popup.dart';

class HomeController extends GetxController {
  RxBool isDrop = false.obs;
  RxBool isLoading = true.obs;
  var businessListModel = BusinessListModel().obs;
  var intrestListData = IntrestListModel().obs;
  String selectedIntrestValue = "";
  // final homeController = Get.put(HomeController());
  @override
  void onInit() {
    // callBusinessListApi();
    // getIntrestList().then((value) {
    //   selectedIntrestValue = intrestListData.value.data![0].name.toString();
    // });

    print("===============");
    update(["id"]);
    super.onInit();
  }

  List categoryNameList = [];
  List visitsPeopleImage = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWpAyuyKd40qgvtzB31luFHUbBH3Ye0fP5sB_kXZ67rfGJe9W1aRw5obRi1cLDfGcNmBo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQguw9Cbx9amQNR6YUviWi9TKJATC-6JVk4diTd15TJ1n4IeGET0jiiKPRZGXWNFGUhOAs&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLt-T4NaOGQej1pSCdQOpa-WsCJXuu-7xiKw&usqp=CAU"
  ];

  // List dropList = [
  //   [ColorRes.color8401FF, "Restaurant"],
  //   [ColorRes.colorWhite, "Club"],
  //   [ColorRes.colorRed, "Bar"],
  // ];

  dropOnTap() {
    isDrop.value = !isDrop.value;
  }

  dropItemTap({required String name, required String category}) {
    selectedIntrestValue = name;
    callBusinessListApi(category: category);
    isDrop.value = false;
    update(["id"]);
  }

  Future getIntrestList() async {
    try {
      isLoading.value = true;
      await IntrestApi.getInterestList().then((value) {
        if (value != null) {
          if (value.status == true) {
            intrestListData.value = value;
            print("intrestModel: res: ---------${intrestListData.value}");
            intrestListData.value.data!.forEach((element) {
              categoryNameList.add(element.name);
              update(["id"]);
            });
            print("list: ---------${categoryNameList.toString()}");
            update(["id"]);
            isLoading.value = false;
          }
          isLoading.value = false;
          update(["id"]);
          // flutterToast("Intersted added successfully");
          // Get.to(() => DashBoardScreen());
        } else {
          isLoading.value = false;
          errorToast(StringRes.errText);
          update(["id"]);
        }
      });
    } catch (e) {
      isLoading.value = false;
      errorToast(StringRes.errText);
      update(["id"]);
      rethrow;
    }
  }

  void callBusinessListApi({String? category, String? name}) {
    try {
      isLoading.value = true;
      businessListModel.value = BusinessListModel();
      BusinessListApi.businessListApi(category: category, name: name)
          .then((value) {
        if (value != null) {
          businessListModel.value = value;
          isLoading.value = false;

          print("businessList  --------->  ${businessListModel.value.status}");
        }
      });
    } catch (e) {
      print("error: =======>> $e");
      rethrow;
    }
  }
}

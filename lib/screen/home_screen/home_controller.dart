import 'package:flutter/foundation.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/business_list_api.dart';
import 'package:sketch/api_call/intrest_api.dart';
import 'package:sketch/model/business_list_model.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/utils/StringRes.dart';
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
    callBusinessListApi();
    getIntrestList().then((value) {
      selectedIntrestValue = intrestListData.value.data![0].name.toString();
    });

    print("===============");
    update(["id"]);
    super.onInit();
  }

  List categoryNameList = [];

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
      // isLoading.value = true;
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
            // isLoading.value = false;
          }
          // isLoading.value = false;
          update(["id"]);
          // flutterToast("Intersted added successfully");
          // Get.to(() => DashBoardScreen());
        } else {
          // isLoading.value = false;
          errorToast(StringRes.errText);
          update(["id"]);
        }
      });
    } catch (e) {
      // isLoading.value = false;
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
          .then((value) async {
        if (value != null) {
          businessListModel.value = value;
          await preloadData();

          // debugPrint(
          //     "businessList  --------->  ${businessListModel.value.status}");
        }
      });
    } catch (e) {
      debugPrint("error: =======>> $e");
      rethrow;
    }
  }

  Future<bool> preloadData() async {
    if (businessListModel.value.data!.isNotEmpty) {
      for (int i = 0; i < businessListModel.value.data!.length; i++) {
        if (businessListModel.value.data![i].cachedPath!.isEmpty) {
          debugPrint(
              "${businessListModel.value.data![i].coverResizeUrl}  -=-=-===-==-=- ${businessListModel.value.data![i].cachedPath}");
          cacheMediaData(url: businessListModel.value.data![i].coverResizeUrl!)
              .then((value) {
            if (value.isNotEmpty) {
              businessListModel.value.data![i].cachedPath = value;
              debugPrint(
                  "${businessListModel.value.data![i].coverResizeUrl}  ===========  ${businessListModel.value.data![i].cachedPath}");
              i == (businessListModel.value.data!.length - 1)
                  ? isLoading.value = false
                  : null;
            } else {
              isLoading.value = false;
            }
          });
        }
      }

      return true;
    } else {
      return false;
    }
  }

  Future<String> cacheMediaData({required String url}) async {
    if (url.contains(".mp4")) {
      final file = await DefaultCacheManager().getSingleFile(url);
      return file.path;
    } else {
      final file = await DefaultCacheManager().getSingleFile(url);
      return file.path;
    }
  }
}

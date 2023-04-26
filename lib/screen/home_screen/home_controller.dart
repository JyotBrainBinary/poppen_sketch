import 'package:get/get.dart';
import 'package:sketch/api_call/business_list_api.dart';
import 'package:sketch/model/business_list_model.dart';


class HomeController extends GetxController{


  RxBool isLoading = true.obs;
  var businessListModel = BusinessListModel().obs;
  @override
  void onInit() {
    callBusinessListApi();
    super.onInit();
  }

  List visitsPeopleImage = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWpAyuyKd40qgvtzB31luFHUbBH3Ye0fP5sB_kXZ67rfGJe9W1aRw5obRi1cLDfGcNmBo&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQguw9Cbx9amQNR6YUviWi9TKJATC-6JVk4diTd15TJ1n4IeGET0jiiKPRZGXWNFGUhOAs&usqp=CAU",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLt-T4NaOGQej1pSCdQOpa-WsCJXuu-7xiKw&usqp=CAU"
  ];

  void callBusinessListApi() {
    try{

        isLoading.value = true;

      BusinessListApi.businessListApi(name: "business details 3").then((value) {
        if (value != null ) {

            businessListModel.value = value;
            isLoading.value = false;

          print("businessList  --------->  ${businessListModel.value.status}");
        }
      });
    }
    catch(e)
    {
      print("error: =======>> $e");
      rethrow;
    }

  }


}
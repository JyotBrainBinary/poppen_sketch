import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/login_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/utils/StringRes.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  RxBool loading = false.obs;

  void validateForm() {
    if (emailController.text.isEmpty) {
      errorToast(StringRes.emailValidation);
    } else if (!emailController.text.isEmail) {
      errorToast(StringRes.invalidEmailValidation);
    } else if (passController.text.isEmpty) {
      errorToast(StringRes.passwordValidation);
    } else {
      callLoginApi();
    }
  }

  void callLoginApi() {
    try {
      loading.value = true;
      LoginApi.loginApi(
              email: emailController.text, password: passController.text)
          .then((value) {
        if (value != null) {
          loading.value = false;
          flutterToast("Login Successfully.");
          Get.to(() => DashBoardScreen());
        } else {
          loading.value = false;
          errorToast(StringRes.errText);
        }
      });
    } catch (e) {
      loading.value = false;
      errorToast(e.toString());
    }
  }
}

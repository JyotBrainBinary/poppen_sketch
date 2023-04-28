import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/login_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/pref_key.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  RxBool loading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void validateForm() {
    if (emailController.text.isEmpty) {
      errorToast(StringRes.emailValidation);
    } else if (!emailController.text.isEmail) {
      errorToast(StringRes.invalidEmailValidation);
    } else if (passController.text.isEmpty) {
      errorToast(StringRes.passwordValidation);
    } else {
      logInUser().then((value) {
        if(value == "done")
          {
            callLoginApi();
          }
      });

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


  Future<String> logInUser({
    String? email,
    String? password,
  }) async {
    String result = 'Some error occurred';
    try {
      loading.value = true;

        await _auth.signInWithEmailAndPassword(
            email: emailController.text, password: passController.text);
          await PrefService.setValue(PrefKeys.uid,
            _auth.currentUser!.uid.toString());
        result = 'done';

    } catch (err) {
      loading.value = false;
      errorToast(StringRes.errText);
    }
    return result;
  }


}

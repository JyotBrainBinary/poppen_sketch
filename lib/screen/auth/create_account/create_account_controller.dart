import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/screen/auth/create_account/sign_up_with_mobile/signup_with_mobile.dart';
import 'package:sketch/utils/StringRes.dart';

class CreateAccountController extends GetxController {


  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  void validation() {
    if (firstNameController.text.isEmpty) {
      errorToast(StringRes.firstNameValidation);

    }
    else if (lastNameController.text.isEmpty) {
      errorToast(StringRes.lastNameValidation);
    }
    else if (emailController.text.isEmpty) {
      errorToast(StringRes.emailValidation);
    }

    else if (passController.text.isEmpty) {
      errorToast(StringRes.passwordValidation);
    }
    else
      {
        Get.to(() => SignUpWithMobile());
      }
  }

}
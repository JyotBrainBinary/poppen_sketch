import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/model/user_model.dart';
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
    } else if (lastNameController.text.isEmpty) {
      errorToast(StringRes.lastNameValidation);
    } else if (emailController.text.isEmpty) {
      errorToast(StringRes.emailValidation);
    } else if (!emailController.text.isEmail) {
      errorToast(StringRes.invalidEmailValidation);
    } else if (passController.text.isEmpty) {
      errorToast(StringRes.passwordValidation);
    } else {
      Get.to(() => SignUpWithMobile(), arguments: {
        "firstName":firstNameController.text,
        "lastName":lastNameController.text,
        "email":emailController.text,
        "password":passController.text
      }

      );
      // signUpUser(
      //         firstName: firstNameController.text,
      //         email: emailController.text,
      //         password: passController.text,
      //         lastName: lastNameController.text)
      //     .then((value) {
      //   if (value == "done") {
      //
      //   }
      // });
    }
  }

  // Future<String> signUpUser({
  //   required String firstName,
  //   required String email,
  //   required String password,
  //   required String lastName,
  // }) async {
  //   String result = 'error';
  //   try {
  //     Loader().showLoader();
  //     print("firstName:-----------$firstName");
  //     print("lastName:-----------$lastName");
  //     print("email:-----------$email");
  //     print("password:-----------$password");
  //
  //     UserCredential user = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     print(user.user!.uid);
  //
  //     UserModel userModel = UserModel(
  //       firstName: firstName,
  //       lastName: lastName,
  //       email: email,
  //       uid: user.user!.uid,
  //     );
  //
  //     await _firestore.collection('users').doc(user.user!.uid).set(
  //           userModel.toJson(),
  //         );
  //     result = 'done';
  //     Loader().hideLoader();
  //     flutterToast("");
  //   } catch (err) {
  //     Loader().hideLoader();
  //     print("err--------$err");
  //     if (err.toString().contains("already in use")) {
  //       errorToast("The email address is already in use by another account.");
  //     } else if (err.toString().contains("A network error")) {
  //       errorToast("Network error");
  //     } else {
  //       errorToast(StringRes.errText);
  //     }
  //     result = err.toString();
  //   }
  //   return result;
  // }


}

import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/register_api.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/model/user_model.dart';
import 'package:sketch/screen/auth/create_account/otp_verify/otp_verify_screen.dart';
import 'package:sketch/screen/auth/create_account/what_intrested/what_intrested_screen.dart';
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/pref_key.dart';

class SignUpWithMobileController extends GetxController {
  String countryCode = "61";
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  String userNumber = '';
  String otp = "";
  String receivedID = "";
  RxBool isLoading = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;
  RxString number = "".obs;

  void validateForm() {
    if (mobileController.text.isEmpty) {
      errorToast(StringRes.mobileNumberValidation);
    } else {
      verifyUserPhoneNumber(phone: mobileController.text.trim());
    }
  }

  void showCountryDialog(BuildContext context) {
    showCountryPicker(
      context: context,
      countryListTheme: CountryListThemeData(
        flagSize: 25,
        backgroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
        bottomSheetHeight: 500, // Optional. Country list modal height
        //Optional. Sets the border radius for the bottomsheet.
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        //Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: 'Search',
          hintText: 'Start typing to search',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
      onSelect: (Country country) {
        countryCode = country.phoneCode;
        debugPrint('Select country: $countryCode');
        debugPrint('Select country: ${country.displayName}');
        update(["id"]);
      },
    );
    update(["id"]);
  }

  void verifyUserPhoneNumber({required String phone, bool? isResendOtp}) {
    try {
      isLoading.value = true;
      String number = "+$countryCode$phone";
      debugPrint("number -----------$number");
      auth.verifyPhoneNumber(
        phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential).then(
                (value) => debugPrint('Logged In Successfully'),
              );
        },
        verificationFailed: (FirebaseAuthException e) {
          debugPrint("-----------${e.message}");
          isLoading.value = false;
          if (e.message!.contains("network error")) {
            errorToast(title: "Verification failed", "No internet connection");
          } else {
            errorToast(title: "Verification failed", StringRes.errText);
          }
        },

        codeSent: (String verificationId, int? resendToken) {
          receivedID = verificationId;
          isLoading.value = false;
          flutterToast("Otp Sent Successfully");
          isResendOtp == true
              ? null
              : Get.to(OtpVerifyScreen(), arguments: {
                  "firstName": Get.arguments["firstName"],
                  "lastName": Get.arguments["lastName"],
                  "email": Get.arguments["email"],
                  "password": Get.arguments["password"],
                  "phone": number
                });
          startTimer();

          debugPrint("verificationId:--------$verificationId");
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      debugPrint("===========$e");
      isLoading.value = false;
      errorToast(e.toString());
      rethrow;
    }
  }

  Future verifyOTPCode(
      {required String otp,
      required String firstName,
      required String lastName,
      required String email,
      required String password,
      required String phone}) async {
    try {
      isLoading.value = true;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: receivedID,
        smsCode: otp,
      );
      await auth.signInWithCredential(credential).then((value) {
        debugPrint('User Login In Successful');

        signUpUser(
                phone: phone,
                email: email,
                firstName: firstName,
                lastName: lastName,
                password: password)
            .then((value) {
          if (value == "done") {
            RegisterApi.registerApi(
              email: email,
              password: password,
              firstName: firstName,
              lastName: lastName,
              phone: phone,
            ).then((value) {
              if (value != null) {
                print("val of register: -=-=-=-=- $value");
                isLoading.value = false;
                Get.offAll(() => WhatIntrestedScreen());
              }
            });
          }
        });
      }).onError((error, stackTrace) {
        isLoading.value = false;
        errorToast(error.toString());
      });
    } catch (e) {
      isLoading.value = false;
      errorToast(e.toString());
      // return false;
      rethrow;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<String> signUpUser({
    required String firstName,
    required String email,
    required String password,
    required String lastName,
    required String phone,
  }) async {
    String result = 'error';
    try {
      isLoading.value = true;
      debugPrint("firstName:-----------$firstName");
      debugPrint("lastName:-----------$lastName");
      debugPrint("email:-----------$email");
      debugPrint("password:-----------$password");
      debugPrint("phone:-----------$phone");

      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      debugPrint(user.user!.uid);
      await PrefService.setValue(PrefKeys.uid, user.user!.uid.toString());

      UserModel userModel = UserModel(
        firstName: firstName,
        lastName: lastName,
        email: email,
        uid: user.user!.uid,
        phone: phone,
      );

      await _firestore.collection('users').doc(user.user!.uid).set(
            userModel.toJson(),
          );
      result = 'done';
      isLoading.value = false;
    } catch (err) {
      isLoading.value = false;
      debugPrint("err--------$err");
      if (err.toString().contains("already in use")) {
        errorToast("The email address is already in use by another account.");
      } else if (err.toString().contains("A network error")) {
        errorToast("Network error");
      } else {
        errorToast(StringRes.errText);
      }

      result = err.toString();
    }
    isLoading.value = false;
    return result;
  }



  bool canResend = false;
  int remainingTime = 30;
   Timer? timer;

  void startTimer() {
    canResend = false;
    remainingTime = 30;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
      } else {
        canResend = true;
        stopTimer();
      }
      update(["id"]);
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer?.cancel();
    }
  }



  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }






}

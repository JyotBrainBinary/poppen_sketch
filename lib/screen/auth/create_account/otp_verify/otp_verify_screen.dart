import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/screen/auth/create_account/otp_verify/otp_verify_controller.dart';
import 'package:sketch/screen/auth/create_account/what_intrested/what_intrested_screen.dart';
import 'package:sketch/screen/auth/login/login_screen.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

class OtpVerifyScreen extends StatelessWidget {
  OtpVerifyScreen({Key? key}) : super(key: key);

  final controller = Get.put(OtpVerifyController());
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ColorRes.colorWhite,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: GetBuilder<OtpVerifyController>(
              id: "id",
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTopAuthScreen(
                      height: height,
                      width: width,
                      title: StringRes.verifyMobile,
                      isOtpVerify: true,
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    const Text(
                      StringRes.sentOtpDesc,
                      style:
                          TextStyle(color: ColorRes.colorC3C3C3, fontSize: 14),
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Text(
                        StringRes.verifyMobile,
                        style:
                            TextStyle(color: ColorRes.colorBlack, fontSize: 14),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Pinput(
                      length: 4,
                      controller: controller.otpController,
                      defaultPinTheme: PinTheme(
                        width: (width * 0.86) / 4,
                        height: (width * 0.86) / 4,
                        textStyle: const TextStyle(
                            fontSize: 14,
                            color: ColorRes.colorBlack,
                            fontWeight: FontWeight.w500),
                        decoration: BoxDecoration(
                          color: ColorRes.colorEBEBEB,
                          borderRadius: BorderRadius.circular(99),
                        ),
                      ),
                      validator: (s) {
                        return s == '2222' ? null : 'Pin is incorrect';
                      },
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      errorTextStyle:
                          const TextStyle(fontSize: 14, color: Colors.red),
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => print(pin),
                    ),
                    SizedBox(
                      height: height * 0.06,
                    ),
                    CommonCreateAccText(
                      text1: StringRes.didNotRecive,
                      text2: StringRes.plsResend,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CommonButton(
                        height: height,
                        width: width,
                        color: ColorRes.color8401FF,
                        text: StringRes.continueText,
                        onTap: () {
                          if (controller.otpController.text.isEmpty) {
                            errorToast(StringRes.verificationCodeValidation);
                          } else {
                            Get.to(() => WhatIntrestedScreen());
                          }
                        }),
                    const Spacer(),
                    CommonCreateAccText(
                      text1: StringRes.doNotHaveAc,
                      text2: StringRes.createOne,
                      onTap: () {},
                    ),
                    SizedBox(
                      height: height * 0.055,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

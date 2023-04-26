import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/screen/auth/create_account/otp_verify/otp_verify_screen.dart';
import 'package:sketch/screen/auth/create_account/sign_up_with_mobile/signup_with_mobile_controller.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

class SignUpWithMobile extends StatelessWidget {
  SignUpWithMobile({Key? key}) : super(key: key);

  final controller = Get.put(SignUpWithMobileController());
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
        body: Stack(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                child: GetBuilder<SignUpWithMobileController>(
                  id: "id",
                  builder: (controller) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonTopAuthScreen(
                          height: height,
                          width: width,
                          title: StringRes.continueSetup,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 3),
                          child: Text(
                            StringRes.mobileNum,
                            style: TextStyle(
                                color: ColorRes.colorBlack, fontSize: 14),
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorRes.colorEBEBEB, width: 1),
                            borderRadius: BorderRadius.circular(26),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.015,
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.showCountryDialog(context);
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.025,
                                      vertical: height * 0.005),
                                  child: Text(
                                    "+${controller.countryCode}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        color: ColorRes.colorB5B5B5),
                                  ),
                                ),
                              ),
                              Container(
                                color: ColorRes.colorD8D8D8,
                                width: 1,
                                height: 25,
                              ),
                              SizedBox(
                                width: width * 0.025,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.mobileController,
                                  keyboardType: TextInputType.number,
                                  style: const TextStyle(
                                      fontSize: 14, color: ColorRes.colorBlack),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: StringRes.mobileHint,
                                    hintStyle: TextStyle(
                                        color: ColorRes.colorB5B5B5,
                                        fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.06,
                        ),
                        CommonButton(
                            height: height,
                            width: width,
                            color: ColorRes.color8401FF,
                            text: StringRes.continueText,
                            onTap: () {
                              controller.validateForm();
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
            Obx(() => controller.isLoading.value
                ? const Center(
                    child: FullScreenLoader(enableBgColor: true),
                  )
                : const SizedBox())
          ],
        ),
      ),
    );
  }
}

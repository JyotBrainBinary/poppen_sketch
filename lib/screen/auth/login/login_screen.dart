import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/screen/auth/create_account/ceate_account_screen.dart';
import 'package:sketch/screen/auth/login/login_controller.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/common/widget/common_text_field.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

import '../widget/common_auth_bottom_area.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController controller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: ColorRes.colorWhite,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTopAuthScreen(
                      height: height,
                      width: width,
                      title: StringRes.signIn,
                    ),
                    CommonTextField(
                      controller: controller.emailController,
                      hintText: StringRes.emailHint,
                      title: StringRes.email,
                      istitle: true,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CommonTextField(
                      controller: controller.passController,
                      hintText: StringRes.passHint,
                      title: StringRes.password,
                      istitle: true,
                    ),
                    SizedBox(
                      height: height * 0.055,
                    ),
                    CommonButton(
                      height: height,
                      width: width,
                      color: ColorRes.color8401FF,
                      text: StringRes.signIn,
                      isRightArrow: true,
                      onTap: () {
                        controller.validateForm();
                      },
                    ),
                    SizedBox(
                      height: height * 0.04,
                    ),
                    CommonAuthBottomArea(
                      onGoogleTap: () {},
                      onFacebookTap: () {},
                    ),


                    SizedBox(
                      height: height * 0.05,
                    ),
                    CommonCreateAccText(
                      text1: StringRes.doNotHaveAc,
                      text2: StringRes.createOne,
                      onTap: () {
                        Get.off(()=>CreateAccountScreen());
                      },
                    ),
                    SizedBox(
                      height: height * 0.055,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => controller.loading.value
              ? const Center(
                  child: FullScreenLoader(enableBgColor: true),
                )
              : const SizedBox())
        ],
      ),
    );
  }


}


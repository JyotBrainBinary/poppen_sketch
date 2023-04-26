import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/screen/auth/login/login_controller.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/common/widget/common_text_field.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/screen/dashbord_screen/dashbord.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

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
                    Row(children: const [
                      Expanded(
                          child: Divider(
                        color: ColorRes.colorD8D8D8,
                        thickness: 1,
                        height: 1,
                      )),
                      Text(
                        "    OR    ",
                        style: TextStyle(
                            fontSize: 14, color: ColorRes.colorB0B0B0),
                      ),
                      Expanded(child: Divider()),
                    ]),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    _buildSignInWithContainer(
                        height: height,
                        width: width,
                        text: StringRes.signInWithGoogle,
                        image: AssetsRes.google,
                        ontap: () {}),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    _buildSignInWithContainer(
                        height: height,
                        width: width,
                        text: StringRes.signInWithFacebook,
                        image: AssetsRes.facebook,
                        ontap: () {

                        }),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    CommonCreateAccText(
                      text1: StringRes.doNotHaveAc,
                      text2: StringRes.createOne,
                      onTap: () {},
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

  Widget _buildSignInWithContainer(
      {required double height,
      required double width,
      required String text,
      required String image,
      required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: height * 0.017),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorRes.colorEBEBEB),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: width * 0.067,
            ),
            SizedBox(
              width: width * 0.03,
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: ColorRes.colorBlack,
                  fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}

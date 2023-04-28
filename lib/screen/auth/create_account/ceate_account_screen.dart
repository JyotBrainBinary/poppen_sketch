import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/auth/create_account/create_account_controller.dart';
import 'package:sketch/screen/auth/login/login_screen.dart';
import 'package:sketch/screen/auth/widget/auth_top_area.dart';
import 'package:sketch/common/widget/common_button.dart';
import 'package:sketch/common/widget/common_text_field.dart';
import 'package:sketch/screen/auth/widget/common_createacc_text.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/color_res.dart';

import '../widget/common_auth_bottom_area.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);
  final CreateAccountController controller = Get.put(CreateAccountController());
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Scaffold(
      backgroundColor: ColorRes.colorWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<CreateAccountController>(
              id: "id",
              builder: (controller) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTopAuthScreen(
                      height: height,
                      width: width,
                      title: StringRes.createAccount,
                    ),

                    CommonTextField(
                      controller: controller.firstNameController,
                      hintText: StringRes.jhon,
                      title: StringRes.firstName,
                      istitle: true,
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    CommonTextField(
                      controller: controller.lastNameController,
                      hintText: StringRes.smith,
                      title: StringRes.lastName,
                      istitle: true,
                    ),
                    SizedBox(
                      height: height * 0.03,
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
                      text: StringRes.continueText,
                      isRightArrow: true,
                      onTap: () {
                        controller.validation();
                      },
                    ),
                    SizedBox(height: height*0.03,),
                    CommonAuthBottomArea(onGoogleTap: (){}, onFacebookTap: (){}),
                    SizedBox(
                      height: height * 0.055,
                    ),
                    // Spacer(),
                    CommonCreateAccText(
                      text1: StringRes.alreadyHaveAc,
                      text2: StringRes.signIn,
                      onTap: () {

                        Get.off(() => LoginScreen());
                      },
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

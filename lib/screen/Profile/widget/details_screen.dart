import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key? key}) : super(key: key);

  ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    List<String> days = [];
    List<String> time = [];

    for (String openingHour
        in profileController.viewBusinessModel.value.data!.openingHours!) {
      final parts = openingHour.split(' ');
      days.add(parts[0]);
      time.add('${parts[1]} ${parts[2]} ${parts[3]} ${parts[4]}');
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(height: Get.height * 0.06),
              Row(
                children: [
                  Image.asset(AssetsRes.location, height: 18),
                  SizedBox(width: Get.width * 0.04),
                  Text(
                    StringRes.address,
                    style: regular(color: ColorRes.color161823),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: 50,
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorRes.colorE9E9E9)),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(profileController
                          .viewBusinessModel.value.data!.address
                          .toString()),
                    ],
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.04),
              Row(
                children: [
                  Image.asset(AssetsRes.phone, height: 15),
                  SizedBox(width: Get.width * 0.04),
                  Text(
                    StringRes.phoneNumber,
                    style: regular(color: ColorRes.color161823),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                height: 50,
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorRes.colorE9E9E9)),
                child: Text(profileController
                    .viewBusinessModel.value.data!.phoneNumber
                    .toString()),
              ),
              SizedBox(height: Get.height * 0.04),
              Row(
                children: [
                  Image.asset(AssetsRes.timer, height: 15),
                  SizedBox(width: Get.width * 0.04),
                  Text(
                    StringRes.openingHours,
                    style: regular(color: ColorRes.color161823),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Container(
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: ColorRes.colorE9E9E9)),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        profileController
                            .viewBusinessModel.value.data!.openingHours!.length,
                        (index) => Column(
                          children: [
                            Text(
                              days[index],
                              style: regular(color: ColorRes.color161823),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                          profileController.viewBusinessModel.value.data!
                              .openingHours!.length, (index) {
                        return Column(
                          children: [
                            Text(
                              time[index].toString(),
                              style: regular(color: ColorRes.color161823),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

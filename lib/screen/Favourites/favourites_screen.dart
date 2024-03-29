import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/loaders.dart';
import 'package:sketch/screen/Favourites/favourites_controller.dart';
import 'package:sketch/screen/Favourites/widget/favourite_box.dart';

class FavouritesScreen extends StatelessWidget {
  FavouritesScreen({Key? key}) : super(key: key);
  final controller = Get.put(FavouritesController());
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    return Stack(
      children: [
        GetBuilder<FavouritesController>(
          id: "id",
          builder: (controller) {
            return FavouriteBox(width: width, height: height);
          },
        ),
        Obx(() => controller.isLoading.value
            ? const Center(
                child: FullScreenLoader(enableBgColor: true),
              )
            :  const SizedBox())
      ],
    );
  }
}

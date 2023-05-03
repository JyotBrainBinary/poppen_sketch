import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/screen/Profile/profileController.dart';
import 'package:sketch/screen/Profile/widget/image_view.dart';
import 'package:sketch/screen/Profile/widget/video_preview.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class FeedScreen extends StatelessWidget {
  FeedScreen({Key? key}) : super(key: key);

  final ProfileController profileController = Get.find<ProfileController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
              childAspectRatio: 1.9 / 2.6),
          itemCount: profileController
              .viewBusinessModel.value.data!.galleryList!.length,
          itemBuilder: (context, index) {
            final item = profileController
                .viewBusinessModel.value.data!.galleryList![index];
            return GestureDetector(
              onTap: () {
                item.endsWith("mp4")
                    ? Get.to(() => VideoPreview(item))
                    : Get.to(() => ImagePreview(item));
              },
              child: Hero(
                tag: item,
                child: Image.network(
                  item.toString(),
                  height: Get.height * 0.2,
                  width: Get.height * 0.2,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Image.asset(
                      AssetsRes.homeImage,
                      height: Get.height * 0.2,
                      width: Get.height * 0.2,
                      fit: BoxFit.cover,
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AssetsRes.homeImage,
                      height: Get.height * 0.2,
                      width: Get.height * 0.2,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

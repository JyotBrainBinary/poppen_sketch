import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/utils/color_res.dart';

class ImagePreview extends StatelessWidget {
  final String url;

  ImagePreview(this.url);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorRes.colorBlack,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.close,
                    size: 25,
                    color: ColorRes.colorWhite,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Hero(
                    tag: url,
                    child: Image.network(url),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

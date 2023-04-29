import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/api_call/favourite_api_call.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';

class HomeBottomArea extends StatelessWidget {
  HomeBottomArea({
    super.key,
    required this.index,
  });
  final int index;

  final HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    RxBool isFav =
        homeController.businessListModel.value.data![index].isFavourite!.obs;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        ///visit
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Row(
        //       children: [
        //         ImageStack(
        //           imageList: homeController.visitsPeopleImage
        //               .map((e) => e.toString())
        //               .toList(),
        //           totalCount: 3,
        //           // If larger than images.length, will show extra empty circle
        //           imageRadius: 32,
        //           // Radius of each images
        //           imageCount: 3,
        //           // Maximum number of images to be shown in stack
        //           imageBorderWidth: 0,
        //
        //           showTotalCount: false,
        //           // Border width around the images
        //         ),
        //         const SizedBox(width: 5),
        //         Text("+6k Visits", style: regularShaow())
        //       ],
        //     ),
        //     const SizedBox(height: 10),
        //     Row(
        //       children: [
        //         Container(
        //           height: Get.height * 0.03,
        //           width: Get.width * 0.22,
        //           color: ColorRes.colorEFC744,
        //           child: Row(
        //             children: List.generate(
        //               4,
        //               (index) => Row(
        //                 children: [
        //                   Container(
        //                     width: 1,
        //                     height: 20,
        //                     color: Colors.grey,
        //                   ),
        //                   SizedBox(
        //                     width: Get.width * 0.05,
        //                   )
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //         const SizedBox(width: 5),
        //         Text("(55)", style: regularShaow())
        //       ],
        //     ),
        //   ],
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
           Icon(Icons.location_pin,color: Colors.white,weight: Get.width*0.04,),
            SizedBox(width: Get.width * 0.01),
            SizedBox(
              width: Get.width * 0.32,
              child: Text(
                homeController.businessListModel.value.data![index].address!.split(",").last
                    .toString(),
                maxLines: 2,

                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: ColorRes.colorWhite,height: 2.7),
              ),
            ),
          ],
        ),

        ///3 icon
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Container(
            //       height: 45,
            //       width: 45,
            //       alignment: Alignment.center,
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(40),
            //         border:
            //             Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
            //       ),
            //       child: Container(
            //         decoration: BoxDecoration(
            //             boxShadow: [
            //               BoxShadow(
            //                 color: ColorRes.colorBlack.withOpacity(0.2),
            //                 blurRadius: 13.0,
            //                 spreadRadius: 0.01,
            //                 // offset: const Offset(1.0, 5.5),
            //               )
            //             ],
            //             image: DecorationImage(
            //               image: AssetImage(AssetsRes.message),
            //               scale: 4.5,
            //             )),
            //       ),
            //     ),
            //     const SizedBox(height: 5),
            //     Text(
            //       "1.5k",
            //       style: regularShaow(),
            //     ),
            //   ],
            // ),
            // const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 42,
                  width: 42,
                  padding: EdgeInsets.all(Get.width * 0.015),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    border:
                        Border.all(color: ColorRes.colorWhite.withOpacity(0.8)),
                    boxShadow: [
                      BoxShadow(
                        color: ColorRes.colorBlack.withOpacity(0.2),
                        blurRadius: 13.0,
                        spreadRadius: 0.01,
                        // offset: const Offset(1.0, 5.5),
                      )
                    ],
                  ),
                  child: Center(child: Image.asset(AssetsRes.share)),
                ),
                const SizedBox(height: 5),
                Text(
                  "SHARE",
                  style: regularShaow(fontSize: 12),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () {
                    return GestureDetector(
                      onTap: () {
                        isFav.value == false
                            ? FavouriteApi.addFavourite(
                                id: homeController
                                    .businessListModel.value.data![index].id
                                    .toString(),
                              )
                            : FavouriteApi.removeFavourite(
                          id: homeController
                              .businessListModel.value.data![index].id
                              .toString(),
                        );
                        isFav.value = !isFav.value;
                        homeController.businessListModel.value.data![index]
                            .isFavourite = isFav.value;
                      },
                      child: Container(
                        height: 42,
                        width: 42,
                        padding: EdgeInsets.all(Get.width * 0.015),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: isFav.value == true
                                  ? ColorRes.colorEFC744
                                  : ColorRes.colorWhite.withOpacity(0.8)),
                          boxShadow: [
                            BoxShadow(
                              color: ColorRes.colorBlack.withOpacity(0.2),
                              blurRadius: 13.0,
                              spreadRadius: 0.01,
                              // offset: const Offset(1.0, 5.5),
                            )
                          ],
                        ),
                        child: Center(
                          child: Image.asset(
                            AssetsRes.star,
                            color: isFav.value == true
                                ? ColorRes.colorEFC744
                                : ColorRes.colorWhite.withOpacity(0.8),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 5),
                Text(
                  "FAVOURITE",
                  style: regularShaow(fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }


  void handleFavourite(){

  }


}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sketch/common/widget/common_appbar.dart';
import 'package:sketch/common/widget/textStyle.dart';
import 'package:sketch/screen/Favourites/favourites_controller.dart';
import 'package:sketch/screen/dashbord_screen/dashboard_controller.dart';
import 'package:sketch/screen/home_screen/home_controller.dart';
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/assets_res.dart';
import 'package:sketch/utils/color_res.dart';
import '../../../common/widget/common_small_button.dart';

class FavouriteBox extends StatelessWidget {
  FavouriteBox({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;
  final controller = Get.find<FavouritesController>();
  final homeController = Get.find<HomeController>();
  final dashBoardController = Get.find<DashBoardController>();

  @override
  Widget build(BuildContext context) {
    return controller.favouriteListModel.data == null
        ? const Center(
            child:
                SizedBox(
                  child: Text("No data found"),
                ),
    )


        : Column(
            children: [
              CommonAppBar(index: 2),
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: controller.favouriteListModel.data!.length,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.04, vertical: height * 0.03),
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: height * 0.035,
                    );
                  },
                  itemBuilder: (context, index) {
                    final item = controller.favouriteListModel.data![index];
                    return SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * 0.025,
                                vertical: height * 0.012),
                            height: Get.height * 0.25,
                            width: Get.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorRes.colorE9E9E9),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    // margin: const EdgeInsets.only(top: 7, right: 7),
                                    height: 20,
                                    width: 20,
                                    color: ColorRes.colorEFC744,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(99),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(99),
                                        child: Image.network(
                                          item.logoUrl.toString(),
                                          height: height * 0.09,
                                          width: height * 0.09,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Image.asset(
                                              AssetsRes.restaurantLogo,
                                              height: height * 0.09,
                                              width: height * 0.09,
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                              AssetsRes.restaurantLogo,
                                              height: height * 0.09,
                                              width: height * 0.09,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      ),

                                      // Image.network(
                                      //   item.logoUrl.toString(),
                                      //   height: height * 0.09,
                                      //   width: height * 0.09,
                                      //   fit: BoxFit.cover,
                                      //   errorBuilder: (context, error, stackTrace) {
                                      //     return Image.asset(
                                      //       AssetsRes.restaurantLogo,
                                      //       height: height * 0.09,
                                      //     );
                                      //   },
                                      // ),
                                    ),
                                    SizedBox(
                                      width: width * 0.03,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name.toString(),
                                          textAlign: TextAlign.start,
                                          style: regular(
                                              color: ColorRes.color161823,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: height * 0.005,
                                        ),
                                        Row(
                                          children: [
                                            Image.asset(
                                              AssetsRes.location,
                                              width: width * 0.04,
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            Text(
                                              item.address.toString(),
                                              style: regular(
                                                  color: ColorRes.color161823,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SizedBox(
                                  height: height * 0.043,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: item.category
                                        .toString()
                                        .split(",")
                                        .toList()
                                        .length,
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: width * 0.01,
                                      );
                                    },
                                    itemBuilder: (context, index2) {
                                      var data = item.category
                                          .toString()
                                          .split(",")
                                          .toList()[index2];

                                      return Container(
                                        // width: width * 0.25,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: width * 0.03,
                                            vertical: height * 0.003),
                                        decoration: BoxDecoration(
                                            color: ColorRes.color161823,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AssetsRes.message,
                                              width: width * 0.053,
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            Text(
                                              homeController.categoryNameList[
                                                  int.parse(data.toString()) -
                                                      1],
                                              style: const TextStyle(
                                                  color: ColorRes.colorWhite,
                                                  fontSize: 12,fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.015,
                          ),
                          Row(
                            children: [
                              CommonSmallButton(
                                image: AssetsRes.direction,
                                ontap: () {
                                  controller.openMap(lat: item.latitude.toString(), long: item.longitude.toString());
                                },
                                text: StringRes.directions,
                              ),
                              SizedBox(
                                width: width * 0.015,
                              ),
                              CommonSmallButton(
                                image: AssetsRes.message,
                                ontap: () {
                                  // homeController.update(["id"]);
                                  dashBoardController.onItemTapped(3);
                                  // dashBoardController.update(["bottomBar"]);
                                  debugPrint(
                                      "-------${dashBoardController.selectedIndex}");
                                },
                                text: StringRes.message,
                              ),
                            ],
                          ),
                          // index == controller.favouriteListModel.data!.length - 1
                          //     ? SizedBox(
                          //         height: height * 0.035,
                          //       )
                          //     : const SizedBox(),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}

// class GridPreview extends StatelessWidget {
//   final List<String> imageUrls = [
//     'https://picsum.photos/id/1005/200/300',
//     'https://picsum.photos/id/1015/200/300',
//     'https://picsum.photos/id/1025/200/300',
//   ];
//   final List<String> videoUrls = [
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
//     'https://flutter.github.io/assets-for-api-docs/assets/videos/elephant.mp4',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GridView.builder(
//         shrinkWrap: true,
//         itemCount: imageUrls.length + videoUrls.length,
//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
//         itemBuilder: (context, index) {
//           // Check if the current item is an image or video
//           if (index < imageUrls.length) {
//             final url = imageUrls[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => ImagePreview(url),
//                 ));
//               },
//               child: Hero(
//                 tag: url,
//                 child: Image.network(url, fit: BoxFit.cover),
//               ),
//             );
//           } else {
//             final url = videoUrls[index - imageUrls.length];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(
//                   builder: (context) => VideoPreview(url),
//                 ));
//               },
//               child: Hero(
//                 tag: url,
//                 child: Container(
//                   color: Colors.black,
//                   child: Center(
//                     child:
//                         Icon(Icons.play_arrow, color: Colors.white, size: 50),
//                   ),
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/business_list_model.dart';
import 'package:sketch/model/favourite_list_model.dart';
import 'package:sketch/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/utils/end_points.dart';

class FavouriteApi {
  static Future addFavourite({ required String id}) async {
    try {
      Map<String, dynamic> body = {"id_business": id};
      http.Response? response = await HttpService.postApi(
        url: EndPoints.addFavourite,
        body:body ,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        debugPrint("body8----------${response.body}");

        return businessListModelFromJson(response.body);
      } else {
        errorToast(jsonDecode(response!.body)["message"]);
        return null;
      }
    } catch (e) {
      errorToast("Error", title: e.toString());
      debugPrint(e.toString());
      return null;
    }
  }




  static Future removeFavourite({ required String id}) async {
    try {
      Map<String, dynamic> body = {"id_business": id};
      http.Response? response = await HttpService.postApi(
        url: EndPoints.removeFavourite,
        body:body ,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        debugPrint("body7----------${response.body}");

        return businessListModelFromJson(response.body);
      } else {
        errorToast(jsonDecode(response!.body)["message"]);
        return null;
      }
    } catch (e) {
      errorToast("Error", title: e.toString());
      debugPrint(e.toString());
      return null;
    }
  }




  static Future favouriteList({  String? id}) async {
    try {
      Map<String, dynamic> body = {};
      http.Response? response = await HttpService.postApi(
        url: EndPoints.favouriteList,
        body:body ,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        debugPrint("body6----------${response.body}");

        return favouriteListModelFromJson(response.body);
      } else {
        debugPrint("e: --------- ${jsonDecode(response!.body)["message"]}");
        // errorToast(jsonDecode(response.body)["message"]);
        return null;
      }
    } catch (e) {
      errorToast("Error", title: e.toString());
      debugPrint("errr --------- ${e.toString()}");
      return null;
    }
  }

}

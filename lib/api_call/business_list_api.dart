import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/business_list_model.dart';
import 'package:sketch/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/utils/end_points.dart';

class BusinessListApi {
  static Future businessListApi({ String? name}) async {
    try {
      Map<String, dynamic> body = {"name": name};
      http.Response? response = await HttpService.postApi(
        url: EndPoints.businessList,
        body:name!= null ? body : null,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        print("body9----------${response.body}");

        return businessListModelFromJson(response.body);
      } else {
        errorToast(jsonDecode(response!.body)["message"]);
        return null;
      }
    } catch (e) {
      errorToast("Error", title: e.toString());
      debugPrint("errr0 -------- ${e.toString()}");
      return null;
    }
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/intrest_list_model.dart';
import 'package:sketch/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/utils/StringRes.dart';
import 'package:sketch/utils/end_points.dart';

class IntrestApi {
  static Future<IntrestListModel?> getInterestList() async {
    try {
      String url = EndPoints.intrestList;

      http.Response? response = await HttpService.getApi(url: url);

      if (response != null && response.statusCode == 200 ) {
        print("body5----------${response.body}");
        return intrestListModelFromJson(response.body);
      }
      else{
        return null;
      }
    } catch (e) {
      errorToast(e.toString());

      return null;
    }

  }

  static Future intrestedApi({required String id}) async {
    try {
      Map<String, dynamic> body = {
        "intersted":"$id"/*intersted*/,
      };

      http.Response? response = await HttpService.postApi(
        url: EndPoints.intrest,
        body: body,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        // await PrefService.setValue(PrefKeys.login, true);
        // await PrefService.setValue(PrefKeys.registerToken,
        //     jsonDecode(response.body)["token"].toString());
        if (jsonDecode(response.body)["status"] == true) {
          print("body4----------${response.body}");
          // flutterToast(jsonDecode(response.body)["message"]);
          return true;
        } else {
          errorToast(StringRes.errText);
          return false;
        }
        // print("body----------${response.body}");
        // flutterToast("Account created successfully");
        // return createAccountModelFromJson(response.body);
      } else {
        errorToast(jsonDecode(response!.body)["message"]);
        return false;
      }
    } catch (e) {
      errorToast("Error", title: e.toString());
      debugPrint(e.toString());
      return false;
    }
  }
}

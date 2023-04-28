import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sketch/common/popup.dart';
import 'package:sketch/model/view_business_model.dart';
import 'package:sketch/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/utils/end_points.dart';

class ViewBusinessApi{
  static Future viewBusinessApiCall({  required String id}) async {
    try {
      Map<String, dynamic> body = {
        "id_business" : id
      };
      http.Response? response = await HttpService.postApi(
        url: EndPoints.viewBusiness,
        body:body ,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        debugPrint("body----------${response.body}");

        return viewBusinessModelFromJson(response.body);
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
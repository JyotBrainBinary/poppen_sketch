import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sketch/common/popup.dart';

import 'package:sketch/model/create_account_model.dart';
import 'package:sketch/model/login_model.dart';
import 'package:sketch/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/end_points.dart';
import 'package:sketch/utils/pref_key.dart';

class LoginApi {
  static Future loginApi(
      {required String email, required String password}) async {
    try {
      Map<String, dynamic> body = {"email": email, "password": password};
      http.Response? response = await HttpService.postApi(
        url: EndPoints.login,
        body: body,
        // header: {"x-access-token": accesToken}
        // )
      );
      if (response != null && response.statusCode == 200) {
        await PrefService.setValue(PrefKeys.login, true);
        await PrefService.setValue(PrefKeys.registerToken,
            jsonDecode(response.body)["token"].toString());

        print("body----------${response.body}");

        return loginModelFromJson(response.body);
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
}

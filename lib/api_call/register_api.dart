import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sketch/common/popup.dart';

import 'package:sketch/model/create_account_model.dart';
import 'package:sketch/services/http_services.dart';
import 'package:http/http.dart' as http;
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/end_points.dart';
import 'package:sketch/utils/pref_key.dart';

class RegisterApi {
  static Future registerApi(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String phone,

      }) async {
    try {

      Map<String, dynamic> body = {
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "password": password,
        "mobile_no": phone,
        "role": "user"
      };
      http.Response? response = await HttpService.postApi(
        url: EndPoints.register,
        isHeader: false,
        body: body,
           // header: {"x-access-token": accesToken}
      // )
      );
      if (response != null && response.statusCode == 200) {
        await PrefService.setValue(PrefKeys.login, true);
        await PrefService.setValue(PrefKeys.registerToken,
            jsonDecode(response.body)["token"].toString());

        print("body----------${response.body}");
        flutterToast("Account created successfully");
        return createAccountModelFromJson(response.body);
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

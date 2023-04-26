import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:sketch/services/pref_service.dart';
import 'package:sketch/utils/pref_key.dart';

class HttpService {
  static Future<http.Response?> getApi({
    required String url,
    Map<String, String>? header,
  }) async {
    try {
      String accessToken = PrefService.getString(PrefKeys.registerToken);
      if (header == null && accessToken.isNotEmpty) {
        header = {
          "Content-Type": "application/json",
          "x-access-token": accessToken,
        };
      }
      if (kDebugMode) {
        print("Url ===> $url");
        print("Header ===> $header");
      }
      return http.get(
        Uri.parse(url),
        headers: header,
      );
    } catch (e) {
      // showToast(e.toString());
      return null;
    }
  }

  static Future<http.Response?> postApi({
    required String url,
    dynamic body,
    bool? isHeader,
    Map<String, String>? header,
  }) async {
    try {
      String accessToken = isHeader == false
          ? ""
          : PrefService.getString(PrefKeys.registerToken);
      header ??= {
        "x-access-token": accessToken
        // "Content-Type": "application/json",
      };
      if (kDebugMode) {
        print("Url ===> $url");
        print("Header ===> $header");
        print("Body ===> $body");
      }
      return http.post(
        Uri.parse(url),
        headers: isHeader == false ? null : header,
        body: body,
      );
    } catch (e) {
      // showToast(e.toString());
      print("=============>>>>>> ${e.toString()} <<<<<<<<=======");
      return null;
    }
  }
}

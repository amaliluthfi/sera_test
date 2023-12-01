import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sera_test/core/storage/app_storage.dart';

class AppNetwork {
  final String url = "https://api.escuelajs.co/api/v1";
  final String? _accessToken = AppStorage().getAccessToken();
  final Dio _dio = Dio();

  Future get(
      {required String path,
      Map<String, dynamic>? data,
      Map<String, dynamic>? params}) async {
    try {
      debugPrint("$path $params");
      var res = await _dio.get("$url$path",
          data: data,
          queryParameters: params,
          options: Options(headers: {"Authorization": "Bearer $_accessToken"}));

      debugPrint("search network result ${res.requestOptions.uri}");

      return res.data;
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future post({required String path, Map<String, dynamic>? data}) async {
    try {
      debugPrint("$url$path ini data $data");
      var res = await _dio.post(
        "$url$path",
        data: data,
      );

      return res.data;
    } on DioException catch (e) {
      debugPrint(e.response?.data["message"] ?? "");
      throw e.response?.data["message"] ?? "something went wrong";
    }
  }
}

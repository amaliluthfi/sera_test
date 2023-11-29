import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AppNetwork {
  final String url = "https://api.escuelajs.co/api/v1";
  final Dio _dio = Dio();

  Future get({required String path, Map<String, dynamic>? data}) async {
    try {
      var res = await _dio.get("$url$path",
          data: data, options: Options(headers: {"Authorization": ""}));

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

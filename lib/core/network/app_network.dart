import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sera_test/core/di/setup_di.dart';
import 'package:sera_test/core/session/bloc/session/session_bloc.dart';
import 'package:sera_test/core/storage/app_storage.dart';

class AppNetwork {
  final String url = "https://api.escuelajs.co/api/v1";
  final String? _accessToken = getIt<AppStorage>().getAccessToken();
  final Dio _dio = Dio();

  Future get({
    required String path,
    Map<String, dynamic>? data,
    Map<String, dynamic>? params,
    String? token,
  }) async {
    try {
      debugPrint(
          "$path $params token ${_accessToken ?? getIt<SessionBloc>().accessToken}");
      var res = await _dio.get("$url$path",
          data: data,
          queryParameters: params,
          options: Options(
              headers: {"Authorization": "Bearer ${_accessToken ?? token}"}));

      debugPrint("response ${res.data}");

      return res.data;
    } on DioException catch (e) {
      debugPrint(e.requestOptions.headers.toString());
      throw e.response?.data["message"] ?? "something went wrong";
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

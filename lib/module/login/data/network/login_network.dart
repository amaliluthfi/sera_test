import 'package:flutter/material.dart';
import 'package:sera_test/common/models/profile_model.dart';
import 'package:sera_test/core/network/app_network.dart';

class SessionNetwork {
  final _network = AppNetwork();

  Future<Map<String, dynamic>> loginNetwork(
      {required Map<String, dynamic> data}) async {
    try {
      var res = await _network.post(path: "/auth/login", data: data);
      return res;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Profile> getUserProfile({required String token}) async {
    try {
      var res = await _network.get(path: "/auth/profile", token: token);
      return profileFromJson(res);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

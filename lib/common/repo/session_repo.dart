import 'package:flutter/material.dart';
import 'package:sera_test/module/login/network/login_network.dart';

class SessionRepo {
  final _network = SessionNetwork();

  Future<Map<String, dynamic>> loginRepo(
      {required Map<String, dynamic> data}) async {
    try {
      return await _network.loginNetwork(data: data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:sera_test/common/models/profile_model.dart';
import 'package:sera_test/core/storage/app_storage.dart';
import 'package:sera_test/module/login/data/network/login_network.dart';

class SessionRepo {
  final _network = SessionNetwork();
  final _storage = AppStorage();

  Future<Map<String, dynamic>> loginRepo(
      {required Map<String, dynamic> data}) async {
    try {
      return await _network.loginNetwork(data: data);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  String? getAccessTokenRepo() {
    return _storage.getAccessToken();
  }

  saveAccessTokenRepo(String accessToken) {
    _storage.saveAccessToken(accessToken);
  }

  Future<void> saveRefreshTokenRepo(String refreshToken) async {
    await _storage.saveRefreshToken(refreshToken);
  }

  Future<Profile> getUserProfileRepo({required String token}) async {
    try {
      return await _network.getUserProfile(token: token);
    } catch (e) {
      rethrow;
    }
  }
}

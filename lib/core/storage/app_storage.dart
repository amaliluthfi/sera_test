import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:sera_test/common/models/product_model.dart';

class AppStorage {
  Box sessionBox = Hive.box("session");
  Box cartBox = Hive.box<Product>("cart");

  saveAccessToken(String accessToken) async {
    sessionBox.put("access_token", accessToken);
  }

  saveRefreshToken(String refreshToken) async {
    sessionBox = await Hive.openBox("session");
    sessionBox.put("refresh_token", refreshToken);
  }

  String? getAccessToken() {
    String? accessToken = sessionBox.get("access_token");

    return accessToken;
  }

  List<Product> getCart() {
    debugPrint("get cart...");
    return cartBox.values.toList() as List<Product>;
  }

  saveCart({required Product data}) {
    cartBox.add(data);
  }

  updateCart({required Product data, required int id}) {
    cartBox.putAt(id, data);
  }

  deleteCart({required int id}) {
    cartBox.deleteAt(id);
  }
}

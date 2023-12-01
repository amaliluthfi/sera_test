import 'package:flutter/widgets.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/network/app_network.dart';

class DetailNetwrok {
  final AppNetwork _network = AppNetwork();

  Future<Product> getProduct({required int id}) async {
    try {
      var res = await _network.get(path: "/products/$id");
      return Product.fromJson(res);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

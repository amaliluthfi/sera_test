import 'package:flutter/widgets.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/network/app_network.dart';

class SearchNetwork {
  final AppNetwork _network = AppNetwork();

  Future<List<Product>> searchProduct({String? params}) async {
    try {
      debugPrint("search params $params");
      var res = await _network.get(
          path: "/products/",
          params: params != null ? {"title": params} : null);
      debugPrint("search result $res");
      return List<Product>.from(res.map((x) => Product.fromJson(x)));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

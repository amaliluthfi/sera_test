import 'package:flutter/foundation.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/network/app_network.dart';
import 'package:sera_test/module/home/data/models/category_model.dart';

class HomeNetwork {
  final _netwrok = AppNetwork();

  Future<List<Categories>> getAllCategory() async {
    try {
      var res = await _netwrok.get(path: "/categories");
      return categoriesFromJson(res);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Product>> getProduct({int? categoryId}) async {
    try {
      var res = await _netwrok.get(
          path: "/products",
          params: categoryId != null ? {"categoryId": categoryId} : null);

      return List<Product>.from(res.map((x) => Product.fromJson(x)));
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

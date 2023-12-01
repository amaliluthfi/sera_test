import 'package:flutter/widgets.dart';
import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/module/detail/data/network/detail_network.dart';

class DetailRepo {
  final DetailNetwrok _network = DetailNetwrok();

  Future<Product> getProductRepo({required int id}) async {
    try {
      return await _network.getProduct(id: id);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}

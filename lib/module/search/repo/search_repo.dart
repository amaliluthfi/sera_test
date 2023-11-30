import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/module/search/data/search_network.dart';

class SearchRepo {
  final _network = SearchNetwork();

  Future<List<Product>> searchProductRepo({String? params}) async {
    try {
      return await _network.searchProduct(params: params);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/module/home/data/models/category_model.dart';
import 'package:sera_test/module/home/data/network/home_network.dart';

class HomeRepo {
  final _homeNetwork = HomeNetwork();

  Future<List<Categories>> getAllCatgeoryRepo() async {
    try {
      return await _homeNetwork.getAllCategory();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Product>> getAllProductRepo({int? cateryId}) async {
    try {
      return await _homeNetwork.getProduct(categoryId: cateryId);
    } catch (e) {
      rethrow;
    }
  }
}

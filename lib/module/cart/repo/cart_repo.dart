import 'package:sera_test/common/models/product_model.dart';
import 'package:sera_test/core/storage/app_storage.dart';

class CartRepo {
  final _storage = AppStorage();

  List<Product> getCartRepo() {
    return _storage.getCart();
  }

  addCartRepo({required Product data}) {
    _storage.saveCart(data: data);
  }

  updateCartRepo({required Product data, required int id}) {
    _storage.updateCart(data: data, id: id);
  }

  deleteCart({required int id}) {
    _storage.deleteCart(id: id);
  }
}

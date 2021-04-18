import 'package:payment_gateway/firebase/firebase_crud.dart';
import 'package:payment_gateway/models.dart';

class ProductsPageController {
  static ProductsPageController _instance;
  static ProductsPageController get instance {
    _instance ??= ProductsPageController();
    return _instance;
  }

  List<ProductItem> products;

  Future<void> getProductsList() async {
    products = [];
    Map<String, dynamic> data =
        await FirebaseCrud.instance.read('app_data/products');
    data.forEach((key, value) {
      products.add(ProductItem.fromJson(value));
    });
  }
}

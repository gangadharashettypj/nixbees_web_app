import 'package:payment_gateway/firebase/firebase_crud.dart';
import 'package:payment_gateway/models.dart';

class ProductsPageController {
  static ProductsPageController _instance;
  static ProductsPageController get instance {
    _instance ??= ProductsPageController();
    return _instance;
  }

  List<ProductItem> products;
  List<ProductVariants> productVariants;

  Future<List<ProductItem>> getProductsList({
    String selectedVariant = 'Bulbs',
  }) async {
    print(selectedVariant);
    products = [];
    Map<String, dynamic> data =
        await FirebaseCrud.instance.read('app_data/products/$selectedVariant');
    data.forEach((key, value) {
      products.add(ProductItem.fromJson(value));
    });
    print(products);
    return products;
  }

  Future<List<ProductVariants>> getProductsVariants() async {
    if (productVariants != null && productVariants.isNotEmpty) {
      return productVariants;
    }
    productVariants = [];
    Map<String, dynamic> data =
        await FirebaseCrud.instance.read('app_data/productsVariants');
    data.forEach((key, value) {
      productVariants.add(ProductVariants.fromJson(value));
    });
    return productVariants;
  }
}

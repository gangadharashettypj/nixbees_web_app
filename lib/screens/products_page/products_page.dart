import 'package:flutter/material.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/screens/products_page/products_page_controller.dart';
import 'package:payment_gateway/screens/products_page/widgets/product_item.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/utils/info_message_template.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ProductsPageController.instance.getProductsList();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (ProductsPageController.instance.products == null) {
      return InfoMessageTemplate(
        'Loading!',
        showLoader: true,
        subTitle: 'Getting products List',
      );
    }
    if (ProductsPageController.instance.products.isEmpty) {
      return InfoMessageTemplate(
        'Sorry!',
        image: MyImages.error,
        subTitle: 'No products found',
      );
    }

    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        children: [
          CustomSizedBox.h60,
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                  ProductsPageController.instance.products.length,
                  (index) => Container(
                    margin: EdgeInsets.all(8),
                    child: ProductItemWidget(
                      item: ProductsPageController.instance.products[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomSizedBox.h80,
        ],
      ),
    );
  }
}

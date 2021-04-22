import 'package:flutter/material.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/screens/products_page/products_page_controller.dart';
import 'package:payment_gateway/screens/products_page/widgets/product_item.dart';
import 'package:payment_gateway/utils/info_message_template.dart';

class ProductsPage extends StatefulWidget {
  final Function(ProductItem) onBuyItem;
  ProductsPage({
    this.onBuyItem,
  });

  @override
  _ProductsPageState createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  PageController controller;

  @override
  Widget build(BuildContext context) {
    controller ??= PageController(
      viewportFraction: getFractionView(context),
      initialPage: 0,
    );
    return FutureBuilder(
      future: ProductsPageController.instance.getProductsList(
        selectedVariant: HomePage.selectedVariant,
      ),
      builder: (context, data) {
        if (!data.hasData) {
          return InfoMessageTemplate(
            'Loading!',
            showLoader: true,
            subTitle: 'Getting products List',
          );
        }
        if (data.data.isEmpty) {
          return InfoMessageTemplate(
            'Sorry!',
            image: MyImages.error,
            subTitle: 'No products found',
          );
        }
        return Container(
          margin: EdgeInsets.all(16),
          child: PageView(
            scrollDirection: Axis.horizontal,
            controller: controller,
            children: List.generate(
              ProductsPageController.instance.products.length,
              (index) => ProductItemWidget(
                item: ProductsPageController.instance.products[index],
                onBuy: () {
                  widget.onBuyItem?.call(
                    ProductsPageController.instance.products[index],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  double getFractionView(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    if (width < 400) {
      return 0.8;
    } else if (width < 800) {
      return 0.5;
    } else {
      return 0.3;
    }
  }
}

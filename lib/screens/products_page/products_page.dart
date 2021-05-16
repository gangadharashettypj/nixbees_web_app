import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/screens/products_page/products_page_controller.dart';
import 'package:payment_gateway/screens/products_page/widgets/product_item.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/utils/info_message_template.dart';
import 'package:payment_gateway/utils/responsiveLayout.dart';

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
  int currentProduct = 1;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ProductsPageController.instance.getProductsList(
        selectedVariant: HomePage.selectedVariant,
      );
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller ??= PageController(
      viewportFraction: getFractionView(context),
      initialPage: ResponsiveLayout.isSmallScreen(context) ? 0 : 1,
    );
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
          Expanded(
            child: PageView(
              scrollDirection: Axis.horizontal,
              controller: controller,
              onPageChanged: (val) {
                setState(() {
                  currentProduct = val + 1;
                });
              },
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
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: MyColors.primary,
                ),
                onPressed: () {
                  controller.previousPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                },
              ),
              CustomSizedBox.w18,
              LabelWidget(
                '$currentProduct/${ProductsPageController.instance.products.length}',
                color: Colors.white,
              ),
              CustomSizedBox.w18,
              IconButton(
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: MyColors.primary,
                ),
                onPressed: () {
                  controller.nextPage(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.ease,
                  );
                },
              ),
            ],
          )
        ],
      ),
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

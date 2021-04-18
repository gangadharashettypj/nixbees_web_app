import 'package:flutter/material.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/screens/products_page/products_page_controller.dart';
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
      margin: EdgeInsets.all(32),
      child: Column(
        children: [
          CustomSizedBox.h100,
          Expanded(
            child: SingleChildScrollView(
              child: Wrap(
                children: List.generate(
                  30,
                  (index) => Container(
                    height: 300,
                    width: 300,
                    color: Colors.white,
                    margin: EdgeInsets.all(8),
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

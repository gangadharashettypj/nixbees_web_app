import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/models.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductItem item;

  const ProductItemWidget({
    Key key,
    this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      child: Column(
        children: [
          ImageWidget(
            imageLocation: item.url,
          ),
        ],
      ),
    );
  }
}

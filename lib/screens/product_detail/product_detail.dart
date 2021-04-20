import 'package:flutter/material.dart';
import 'package:payment_gateway/models.dart';

class ProductDetail extends StatefulWidget {
  static const String route = '/productDetail';
  final ProductItem item;

  const ProductDetail({
    Key key,
    this.item,
  }) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      color: Colors.red,
    );
  }
}

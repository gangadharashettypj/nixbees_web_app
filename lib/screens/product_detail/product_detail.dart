import 'package:flutter/material.dart';

class ProductDetail extends StatefulWidget {
  static const String route = '/productDetail';

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

import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';

class PaymentResult extends StatefulWidget {
  final String orderId;

  const PaymentResult({
    Key key,
    this.orderId,
  }) : super(key: key);
  @override
  _PaymentResultState createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: LabelWidget(
            widget.orderId,
            size: 20,
          ),
        ),
      ),
    );
  }
}

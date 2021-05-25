import 'package:firebase_database/firebase_database.dart';
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
  String response = '';
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseDatabase.instance
          .reference()
          .child('transactions')
          .child(widget.orderId)
          .onValue
          .listen((event) {
        setState(() {
          response = event.snapshot.value.toString();
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              LabelWidget(
                widget.orderId,
                size: 20,
              ),
              LabelWidget(
                response,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

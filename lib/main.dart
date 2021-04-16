import 'dart:html';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/payment_util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text('Make Web Payment'),
              onPressed: () async {
                if (kIsWeb)
                  PaymentUtil.instance.makeWebPayment(
                    PaymentModel(
                      customerEmail: 'gs@gmail.com',
                      customerName: 'Gangadhara',
                      customerPhone: '919916548851',
                      orderAmount: '1',
                      orderNote: 'Note note',
                      stage: PaymentMode.prod,
                    ).toJsonString(),
                  );
              },
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // ElevatedButton(
            //   child: Text('Make Upi Payment'),
            //   onPressed: () {
            //     PaymentUtil.instance. makeUpiPayment(
            //       {
            //                     'orderId': orderId,
            //                     'orderAmount': orderAmount,
            //                     'customerName': customerName,
            //                     'orderNote': orderNote,
            //                     'orderCurrency': orderCurrency,
            //                     'appId': appId,
            //                     'customerPhone': customerPhone,
            //                     'customerEmail': customerEmail,
            //                     if (!kIsWeb) 'stage': stage,
            //                     if (!kIsWeb) 'tokenData': tokenData,
            //                     'notifyUrl': notifyUrl,
            //                     'returnUrl': notifyUrl,
            //                   },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}

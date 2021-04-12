import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
              onPressed: () {
                makePayment();
              },
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // ElevatedButton(
            //   child: Text('Make Upi Payment'),
            //   onPressed: () {
            //     makeUpiPayment();
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  String orderId = "Order1112";
  String stage = "TEST";
  String orderAmount = "1";
  String tokenData =
      "Lf9JCN4MzUIJiOicGbhJCLiQ1VKJiOiAXe0Jye.Pr9JiMlRmZlZWOkljM3AjNiojI0xWYz9lIsETOxYTM3AjM2EjOiAHelJCLiIlTJJiOik3YuVmcyV3QyVGZy9mIsEjOiQnb19WbBJXZkJ3biwiIyETMxIXZkJ3TiojIklkclRmcvJye.lNsbOgCdMC8r5_LPVABr10prlMZi3v51BGShLK6kmOw-AHMq7_XCW1QXt50L2Kx8QN";
  String customerName = "vasantha";
  String orderNote = "My note";
  String orderCurrency = "INR";
  String appId = "62310f738831161c7d305b36b01326";
  String customerPhone = "9972123520";
  String customerEmail = "gs@nixbees.com";
  String notifyUrl = "https://test.gocashfree.com/notify";
  makePayment() {
    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    if (kIsWeb) {
      launchWebUI(inputParams);
    } else {
      CashfreePGSDK.doPayment(inputParams)
          .then((value) => value?.forEach((key, value) {
                print("$key : $value");
                //Do something with the result
              }));
    }
  }

  Future<void> makeUpiPayment() async {
    Map<String, dynamic> inputParams = {
      "orderId": orderId,
      "orderAmount": orderAmount,
      "customerName": customerName,
      "orderNote": orderNote,
      "orderCurrency": orderCurrency,
      "appId": appId,
      "customerPhone": customerPhone,
      "customerEmail": customerEmail,
      "stage": stage,
      "tokenData": tokenData,
      "notifyUrl": notifyUrl
    };

    CashfreePGSDK.doUPIPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
              //Do something with the result
            }));
  }

  void launchWebUI(Map<String, dynamic> inputParams) async {
    String data = '';
    inputParams.keys.toSet().forEach((element) {
      data = data + element + inputParams[element];
    });
    final message = data.codeUnits;
    final secretKey = 'a16545dce9c612f03d7cf39c614d8c7f6cd5d544'.codeUnits;
    var hmacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
    var signature = hmacSha256.convert(message);
    inputParams['signature'] = base64Encode(signature.bytes);
    print(jsonEncode(inputParams).toString());
    var formData = FormData.fromMap(inputParams);
    await Dio().post(
      'https://test.cashfree.com/billpay/checkout/post/submit',
      data: formData,
      options: Options(
        headers: {
          'Access-Control-Allow-Origin': '*',
          'Accept': 'application/json',
          "Access-Control-Allow-Headers":
              "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST",
        },
      ),
    );

    // var headers = {
    //   'Content-Type': 'application/json',
    //   "Access-Control-Allow-Origin": "*",
    //   "Access-Control-Allow-Headers":
    //       "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
    //   "Access-Control-Allow-Methods": "POST"
    // };
    // var request = Request(
    //   'POST',
    //   Uri.parse(
    //     'https://test.cashfree.com/api/v2/cftoken/order',
    //   ),
    // );
    // request.body = jsonEncode(inputParams);
    // request.headers.addAll(headers);
    //
    // StreamedResponse response = await request.send();
    //
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }
  }
}

import 'dart:convert';

import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentUtil {
  static PaymentUtil _instance;
  static PaymentUtil get instance {
    _instance ??= PaymentUtil();
    return _instance;
  }

  Future<String> makeMobilePayment(Map<String, dynamic> inputParams) async {
    CashfreePGSDK.doPayment(inputParams).then(
      (value) => value?.forEach(
        (key, value) {
          print("$key : $value");
        },
      ),
    );
    return '';
  }

  Future<void> makeWebPayment(String input) async {
    await launch(
        'https://us-central1-nestbees.cloudfunctions.net/makePayment?paymentRequest=$input');
  }

  Future<void> makeUpiPayment(Map<String, dynamic> inputParams) async {
    CashfreePGSDK.doUPIPayment(inputParams)
        .then((value) => value?.forEach((key, value) {
              print("$key : $value");
            }));
  }

  String getSignature(Map<String, String> inputParams) {
    String data = '';
    (inputParams.keys.toList()..sort()).forEach((element) {
      data = data + element + inputParams[element];
    });
    final message = data.codeUnits;
    final secretKey = '<secretkey>'.codeUnits;
    var hMacSha256 = Hmac(sha256, secretKey); // HMAC-SHA256
    var signature = hMacSha256.convert(message);
    return base64Encode(signature.bytes);
  }

  Future<String> launchWebUI(Map<String, String> inputParams) async {
    inputParams['signature'] = getSignature(inputParams);
    final d = await Dio().post(
      // 'https://payments-test.cashfree.com/pgbillpayuiapi/checkout/post/submit',
      'https://test.cashfree.com/billpay/checkout/post/submit',
      data: json.encode(inputParams),
      options: Options(
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      ),
    );
    return d.data;
  }
}

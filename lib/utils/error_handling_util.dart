/*
 * @Author GS
 */
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/button_widget.dart';
import 'package:payment_gateway/utils/no_internet_widget.dart';

class ErrorHandlingUtil {
  static Future<bool> checkInternet(BuildContext context,
      {Function onRetry}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            content: Builder(
              builder: (context) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      child: NoInternetWidget(),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    ButtonWidget(
                      title: onRetry == null ? 'Ok' : 'Retry',
                      onPressed: () {
                        Navigator.of(context).pop();
                        if (onRetry != null) onRetry();
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      );
      return true;
    } else {
      return false;
    }
  }
}

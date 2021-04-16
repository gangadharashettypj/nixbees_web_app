/*
 * @Author GS
 */

import 'package:fluttertoast/fluttertoast.dart';
import 'package:payment_gateway/resources/colors.dart';

class CustomToast {
  static void show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: MyColors.primary.withAlpha(200),
      textColor: RawColors.blackDark,
    );
  }
}

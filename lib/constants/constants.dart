/*
 * @Author GS
 */
import 'package:payment_gateway/utils/enviornment_util.dart';

class Constants {
  static bool get isNeu => true;
  static bool get debugShowCheckedModeBanner => false;
  static String authToken;
  static String industryId;
  static Environment get environment => Environment.testing;
}

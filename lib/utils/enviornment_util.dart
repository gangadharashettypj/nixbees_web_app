/*
 * @Author GS
 */
import 'package:payment_gateway/constants/constants.dart';

class EnvironmentUtil {
  static String get separator => '.';
  static String get prefixWithSeparator =>
      '$prefix${prefix.isEmpty ? '' : separator}';
  static String get prefix {
    switch (Constants.environment) {
      case Environment.testing:
        return 'testing';
      case Environment.pre_prod:
        return 'pre_prod';
      case Environment.prod:
        return '';
      default:
        return 'testing';
    }
  }
}

enum Environment { testing, pre_prod, prod }

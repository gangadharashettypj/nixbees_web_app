/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/scaffold/my_scaffold.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/screens/payment_result/payment_result.dart';
import 'package:payment_gateway/screens/product_detail/product_detail.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name.startsWith('/transactions')) {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => PaymentResult(
          orderId: settings.name.split('/').last,
        ),
      );
    }
    switch (settings.name) {
      case HomePage.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => HomePage(),
        );
      case ProductDetail.route:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => ProductDetail(),
        );
      default:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => MyScaffold(
            body: Center(
              child: Text(
                'No route defined for ${settings.name}',
              ),
            ),
          ),
        );
    }
  }
}

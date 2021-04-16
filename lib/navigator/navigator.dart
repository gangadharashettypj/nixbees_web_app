/*
 * @Author GS
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  static NavigationService _instance;
  static NavigationService get instance {
    _instance ??= NavigationService();
    return _instance;
  }

  Future<dynamic> push(BuildContext context, String route,
      {dynamic arguments}) async {
    return Navigator.of(context).pushNamed(route, arguments: arguments);
  }

  Future<dynamic> pushReplacement(BuildContext context, String route,
      {dynamic arguments}) async {
    return Navigator.of(context)
        .pushReplacementNamed(route, arguments: arguments);
  }

  void pop(BuildContext context, {dynamic arguments}) {
    Navigator.of(context).pop(arguments);
  }

  void popAll(BuildContext context, {dynamic arguments}) async {
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
}

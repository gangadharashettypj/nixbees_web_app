/*
 * @Author GS
 */

import 'package:flutter/material.dart';
import 'package:payment_gateway/utils/info_message_template.dart';
import 'package:provider/provider.dart';

class ScaffoldProvider with ChangeNotifier implements ReassembleHandler {
  final BuildContext context;
  bool _loaderEnabled = false;
  bool _noInternet = false;
  bool _error = false;
  bool _customError = false;
  Widget customErrorWidget;
  Function _onRetry;

  bool get loaderEnabled => _loaderEnabled;
  bool get noInternetScreenEnabled => _noInternet;
  bool get errorScreenEnabled => _error;
  bool get customErrorScreenEnabled => _customError;
  Function get onRetry => _onRetry;

  void showLoader() {
    if (_loaderEnabled) return;
    _loaderEnabled = true;
    notifyListeners();
  }

  void hideLoader() {
    if (!_loaderEnabled) return;
    _loaderEnabled = false;
    notifyListeners();
  }

  void showError({Function onRetry}) {
    if (_error) return;
    _error = true;
    _onRetry = onRetry;
    notifyListeners();
  }

  void hideError() {
    if (!_error) return;
    _error = false;
    notifyListeners();
  }

  void showCustomError(String title,
      {String errorImage, String subTitle, Function onRetry}) {
    _customError = true;
    customErrorWidget = InfoMessageTemplate(
      title,
      ctaMessage: onRetry == null ? null : 'Retry',
      image: errorImage,
      ctaPressed: onRetry,
      subTitle: subTitle,
    );
    notifyListeners();
  }

  void hideCustomError() {
    if (!_customError) return;
    _customError = false;
    notifyListeners();
  }

  void showNoInternetScreen({Function onRetry}) {
    if (_noInternet) return;
    _onRetry = onRetry;
    _noInternet = true;
    notifyListeners();
  }

  void hideNoInternetScreen() {
    if (!_noInternet) return;
    _noInternet = false;
    notifyListeners();
  }

  void hideAllScreen() {
    _noInternet = false;
    _error = false;
    _customError = false;
    _loaderEnabled = false;
    notifyListeners();
  }

  ScaffoldProvider({this.context});
  @override
  void reassemble() {
    notifyListeners();
  }

  Future<dynamic> makeApiCall(
    Future<dynamic> Function() apiCall, {
    bool showError = true,
    bool responseNotNull = true,
    bool showNoInternet = true,
  }) async {
    return await apiCall.call();
  }
}

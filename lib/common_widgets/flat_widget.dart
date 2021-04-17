/*
 * @Author GS
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/common_widgets/button_loader_controller.dart';
import 'package:payment_gateway/common_widgets/circular_progress_indicator.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:provider/provider.dart';

class FlatButtonWidget extends StatelessWidget {
  final Function onPressed;
  final bool expanded;
  final String title;
  final Color color;
  final double loaderSize;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final TextDecoration textDecoration;
  final TextDecorationStyle textDecorationStyle;
  final double fontSize;
  final ButtonLoadingAnimationController controller;
  final Widget prefix, suffix;
  final bool showUnderline;

  FlatButtonWidget({
    this.onPressed,
    @required this.title,
    this.expanded = true,
    this.padding,
    this.color,
    this.textDecoration,
    this.textDecorationStyle,
    this.fontSize,
    this.loaderSize = 24,
    this.controller,
    this.showUnderline = false,
    this.prefix,
    this.suffix,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    if (expanded) {
      return getButtonWidget();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: getButtonWidget(),
          ),
        ],
      );
    }
  }

  Widget getButtonWidget() {
    return ChangeNotifierProvider<ButtonLoadingAnimationController>.value(
      value: controller,
      child: Consumer<ButtonLoadingAnimationController>(
        builder: (context, value, child) {
          return Container(
            padding: padding,
            margin: margin,
            child: controller != null && controller.showLoading
                ? CircularProgressIndicatorWidget(
                    size: loaderSize,
                  )
                : Center(
                    child: Container(
                      padding: padding ?? EdgeInsets.symmetric(horizontal: 32),
                      child: TextButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (prefix != null)
                              Container(
                                child: prefix,
                                margin: EdgeInsets.only(right: 8),
                              ),
                            if (showUnderline)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: color ?? MyColors.primary,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  title,
                                  style: TextStyle(
                                    color: color ?? MyColors.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: fontSize ?? 24,
                                    decoration: textDecoration,
                                    decorationStyle: textDecorationStyle,
                                  ),
                                ),
                              ),
                            if (!showUnderline)
                              Text(
                                title,
                                style: TextStyle(
                                  color: color ?? MyColors.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: fontSize ?? 24,
                                  decoration: textDecoration,
                                  decorationStyle: textDecorationStyle,
                                ),
                              ),
                            if (suffix != null)
                              Container(
                                child: suffix,
                                margin: EdgeInsets.only(left: 8),
                              ),
                          ],
                        ),
                        onPressed: onPressed,
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }
}

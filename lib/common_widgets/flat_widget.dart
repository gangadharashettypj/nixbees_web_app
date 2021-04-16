/*
 * @Author GS
 */
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
  final EdgeInsets padding;
  final TextDecoration textDecoration;
  final TextDecorationStyle textDecorationStyle;
  final double fontSize;
  final ButtonLoadingAnimationController controller;

  FlatButtonWidget(
      {this.onPressed,
      this.title,
      this.expanded = true,
      this.padding,
      this.color,
      this.textDecoration,
      this.textDecorationStyle,
      this.fontSize,
      this.controller});
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
          return NeumorphicButton(
            padding: padding,
            style: NeumorphicStyle(
              boxShape: NeumorphicBoxShape.stadium(),
              depth: 0,
            ),
            child: controller != null && controller.showLoading
                ? CircularProgressIndicatorWidget()
                : Center(
                    child: Container(
                      padding: padding ?? EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        title,
                        style: TextStyle(
                          color: color ?? MyColors.textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: fontSize ?? 18,
                          decoration: textDecoration,
                          decorationStyle: textDecorationStyle,
                        ),
                      ),
                    ),
                  ),
            onPressed: onPressed,
          );
        },
        child: NeumorphicButton(
          padding: padding,
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.stadium(),
            depth: 0,
          ),
          child: Center(
            child: Container(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 32),
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
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

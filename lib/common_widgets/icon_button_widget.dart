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

class IconButtonWidget extends StatelessWidget {
  final Function onPressed;
  final IconData iconData;
  final double iconSize;
  final Color color;
  final double depth;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final ButtonLoadingAnimationController controller;
  final NeumorphicBoxShape buttonBoxShape;

  IconButtonWidget({
    this.onPressed,
    @required this.iconData,
    this.iconSize,
    this.padding,
    this.color,
    this.depth,
    this.controller,
    this.buttonBoxShape,
    this.margin,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: getButtonWidget(),
        ),
      ],
    );
  }

  Widget getButtonWidget() {
    return ChangeNotifierProvider<ButtonLoadingAnimationController>.value(
      value: controller,
      child: Consumer<ButtonLoadingAnimationController>(
        builder: (context, value, child) {
          return NeumorphicButton(
            padding: padding,
            margin: margin,
            style: NeumorphicStyle(
              boxShape: buttonBoxShape ?? NeumorphicBoxShape.stadium(),
              depth:
                  controller != null && controller.showLoading ? 0 : depth ?? 4,
            ),
            child: controller != null && controller.showLoading
                ? CircularProgressIndicatorWidget()
                : Center(
                    child: Container(
                      padding: padding ?? EdgeInsets.symmetric(horizontal: 32),
                      child: Icon(
                        iconData,
                        size: iconSize,
                        color: color ?? MyColors.primary,
                      ),
                    ),
                  ),
            onPressed: onPressed,
          );
        },
        child: NeumorphicButton(
          padding: padding,
          style: NeumorphicStyle(
            boxShape: buttonBoxShape ?? NeumorphicBoxShape.stadium(),
            depth: depth ?? 4,
          ),
          child: Center(
            child: Container(
              padding: padding ?? EdgeInsets.symmetric(horizontal: 32),
              child: Icon(
                iconData,
                size: iconSize,
                color: color ?? MyColors.primary,
              ),
            ),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}

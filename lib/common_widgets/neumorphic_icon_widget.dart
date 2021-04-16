/*
 * @Author GS
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/common_widgets/button_loader_controller.dart';
import 'package:payment_gateway/common_widgets/circular_progress_indicator.dart';
import 'package:provider/provider.dart';

class NeumorphicIconButtonWidget extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  final Color color;
  final double depth;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double size;
  final ButtonLoadingAnimationController controller;

  NeumorphicIconButtonWidget({
    this.onPressed,
    @required this.icon,
    this.padding,
    this.color,
    this.depth,
    this.controller,
    this.margin,
    this.size,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ChangeNotifierProvider<ButtonLoadingAnimationController>.value(
            value: controller,
            child: Consumer<ButtonLoadingAnimationController>(
              builder: (context, value, child) {
                return NeumorphicButton(
                  padding: padding,
                  margin: margin,
                  style: NeumorphicStyle(
                    depth: 0,
                  ),
                  child: controller != null && controller.showLoading
                      ? CircularProgressIndicatorWidget(
                          size: size,
                        )
                      : Center(
                          child: Container(
                            padding: padding ?? EdgeInsets.zero,
                            child: NeumorphicIcon(
                              icon,
                              size: size,
                              style: NeumorphicStyle(
                                color: color,
                                depth: depth,
                              ),
                            ),
                          ),
                        ),
                  onPressed: onPressed,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

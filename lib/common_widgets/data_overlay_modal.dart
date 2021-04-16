/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/common_widgets/button_loader_controller.dart';
import 'package:payment_gateway/common_widgets/button_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/navigator/navigator.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';

class OverlayModal extends StatelessWidget {
  final Widget child;
  final bool showRightButton;
  final bool showLeftButton;
  final bool showCrossButton;
  final bool closeOnOutsideClick;
  final bool closeOnButtonPress;
  final String leftButtonText, rightButtonText, title;
  final Future Function() onLeftButtonPressed, onRightButtonPressed;
  ButtonLoadingAnimationController controller =
      ButtonLoadingAnimationController();

  OverlayModal({
    Key key,
    this.child,
    this.showRightButton = false,
    this.showLeftButton = false,
    this.showCrossButton = false,
    this.closeOnOutsideClick = true,
    this.leftButtonText = 'Cancel',
    this.rightButtonText = 'Okay',
    this.title,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
    this.closeOnButtonPress = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      padding: MediaQuery.of(context).viewInsets,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: LabelWidget(
                          title,
                          size: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child,
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      ButtonWidget(
                        title: leftButtonText,
                        onPressed: () async {
                          await onLeftButtonPressed?.call();
                          if (closeOnButtonPress) {
                            NavigationService.instance.pop(context);
                          }
                        },
                        color: Colors.red,
                        depth: 0,
                        expanded: false,
                        fontSize: 14,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      ButtonWidget(
                        controller: controller,
                        title: rightButtonText,
                        onPressed: () async {
                          controller.startLoadingAnimation();
                          await onRightButtonPressed?.call();
                          controller.stopLoadingAnimation();
                          if (closeOnButtonPress) {
                            NavigationService.instance.pop(context);
                          }
                        },
                        expanded: false,
                        fontSize: 14,
                        padding:
                            EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      ),
                    ],
                  ),
                ),
                CustomSizedBox.h12,
              ],
            ),
          ),
          if (showCrossButton)
            Positioned(
              right: 8,
              top: 8,
              child: NeumorphicButton(
                style: NeumorphicStyle(
                  depth: 2,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(8),
                onPressed: () {
                  NavigationService.instance.pop(context);
                },
              ),
            ),
        ],
      ),
    );
  }
}

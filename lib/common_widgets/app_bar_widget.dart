/*
 * @Author GS
 */

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/common_widgets/icon_widget.dart';
import 'package:payment_gateway/resources/colors.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final double titleSize;
  final String subTitle;
  final IconData leftIconData;
  final Function onLeftIconPressed;
  final Function onRightIconPressed;
  final IconData rightIconData;
  final Widget rightIconWidget;
  final bool handleBackPress;
  final bool showLeftIcon;
  final EdgeInsets margin;
  final EdgeInsets padding;

  const AppBarWidget(
      {Key key,
      this.title,
      this.leftIconData,
      this.onLeftIconPressed,
      this.onRightIconPressed,
      this.rightIconData,
      this.handleBackPress = true,
      this.rightIconWidget,
      this.margin,
      this.showLeftIcon = true,
      this.padding,
      this.subTitle,
      this.titleSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.only(top: 32, left: 16, right: 16),
      margin: margin,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              showLeftIcon
                  ? IconWidget(
                      icon: leftIconData ?? Icons.arrow_back,
                      onTap: handleBackPress
                          ? () => Navigator.of(context).pop()
                          : onLeftIconPressed,
                    )
                  : Container(),
              rightIconData == null
                  ? rightIconWidget ?? Container()
                  : IconWidget(
                      icon: rightIconData,
                      onTap: onRightIconPressed,
                    )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: 4,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: titleSize ?? 28,
                fontWeight: FontWeight.bold,
                color: MyColors.textColor,
              ),
            ),
          ),
          if (subTitle != null)
            Padding(
              padding: EdgeInsets.only(
                // top: 32,
                bottom: 12,
              ),
              child: Text(
                subTitle,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: MyColors.textColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

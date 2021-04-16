/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/resources/colors.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final double size;
  final double depth;
  final Color color;

  const IconWidget({
    Key key,
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.depth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        boxShape: NeumorphicBoxShape.circle(),
        shape: NeumorphicShape.concave,
        color: MyColors.neuBackground,
        depth: depth,
      ),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(8),
          color: Colors.transparent,
          child: Icon(
            icon,
            size: size,
            color: color,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

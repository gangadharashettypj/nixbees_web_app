/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class IconWidget extends StatelessWidget {
  final IconData icon;
  final Function onTap;
  final double size;
  final double depth;
  final Color color;
  final Color backgroundColor;

  const IconWidget({
    Key key,
    this.icon,
    this.onTap,
    this.size,
    this.color,
    this.depth,
    this.backgroundColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Container(
          padding: EdgeInsets.all(8),
          color: backgroundColor ?? Colors.transparent,
          child: Icon(
            icon,
            size: size,
            color: color,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}

/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:payment_gateway/resources/colors.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  final double size;

  CircularProgressIndicatorWidget({
    Key key,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Neumorphic(
        style: NeumorphicStyle(
          boxShape: NeumorphicBoxShape.circle(),
          depth: 3,
          shape: NeumorphicShape.concave,
          color: MyColors.neuBackground,
        ),
        child: Container(
          padding: EdgeInsets.all(5),
          child: Stack(
            children: [
              Container(
                width: size,
                height: size,
                child: CircularProgressIndicator(
                  strokeWidth: 10,
                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.primary),
                  backgroundColor: MyColors.primary.withAlpha(60),
                ),
              ),
              Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.circle(),
                  shape: NeumorphicShape.concave,
                  depth: 2,
                  color: MyColors.neuBackground,
                ),
                child: Container(
                  width: size,
                  height: size,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

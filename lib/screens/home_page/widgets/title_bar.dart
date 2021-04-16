import 'dart:math' as ma;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 30,
          child: OverflowBox(
            maxHeight: 250,
            maxWidth: 120,
            alignment: Alignment.centerLeft,
            child: Lottie.asset(
              MyLottieFile.swingingLamp,
            ),
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                RawColors.blackTranslucent,
                RawColors.blackTranslucent,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(ma.pi / 4),
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                RawColors.blackTranslucent,
                RawColors.blackTranslucent,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(ma.pi / 4),
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                RawColors.blackTranslucent,
                RawColors.blackTranslucent,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(ma.pi / 4),
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                RawColors.blackTranslucent,
                RawColors.blackTranslucent,
                Colors.black,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              transform: GradientRotation(ma.pi / 4),
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Container(
          height: 100,
          width: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                RawColors.blackTranslucent,
                RawColors.blackTranslucent,
                Colors.black,
              ],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              transform: GradientRotation(ma.pi / 4),
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        Container(
          height: 70,
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              ImageWidget(
                imageLocation: MyImages.logo,
              ),
              CustomSizedBox.w30,
              LabelWidget(
                'Lightings',
                color: RawColors.whiteTranslucent,
                fontWeight: FontWeight.bold,
                size: TextSize.title,
              ),
              Expanded(
                child: Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

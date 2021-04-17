import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          ImageWidget(
            imageLocation: MyImages.logo,
            height: 70,
            width: 100,
          ),
          CustomSizedBox.w24,
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
    );
  }
}

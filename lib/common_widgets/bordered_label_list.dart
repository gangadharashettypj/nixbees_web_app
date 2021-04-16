/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';

class BorderedLabelWidget extends StatelessWidget {
  final Map<String, String> labelWidgets;
  final double width;
  final double spacing;
  final Color color;
  final EdgeInsets padding;
  BorderedLabelWidget({
    @required this.labelWidgets,
    this.width,
    this.color,
    this.padding,
    this.spacing,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(
          width: width ?? 1,
          color: color ?? MyColors.textColor,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          labelWidgets.length,
          (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelWidget(
                labelWidgets.keys.toList()[index],
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 12,
              ),
              LabelWidget(
                labelWidgets[labelWidgets.keys.toList()[index]],
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: spacing,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

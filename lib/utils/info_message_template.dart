/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/button_widget.dart';
import 'package:payment_gateway/common_widgets/circular_progress_indicator.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class InfoMessageTemplate extends StatelessWidget {
  final String title;
  final String ctaMessage;
  final String image;
  final String subTitle;
  final Function ctaPressed;
  final bool showLoader;

  InfoMessageTemplate(
    this.title, {
    this.ctaMessage,
    this.image,
    this.subTitle,
    this.ctaPressed,
    this.showLoader = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              ImageWidget(
                imageLocation: image,
                height: MediaQuery.of(context).size.height * 0.12,
              ),
            if (showLoader) CircularProgressIndicatorWidget(),
            CustomSizedBox.h60,
            LabelWidget(
              title,
              size: TextSize.title,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
            if (subTitle != null) CustomSizedBox.h12,
            if (subTitle != null)
              LabelWidget(
                subTitle,
                size: TextSize.subTitle,
                textAlign: TextAlign.center,
              ),
            if (ctaMessage != null) CustomSizedBox.h30,
            if (ctaMessage != null)
              ButtonWidget(
                title: ctaMessage,
                onPressed: ctaPressed,
                expanded: false,
              ),
          ],
        ),
      ),
    );
  }
}

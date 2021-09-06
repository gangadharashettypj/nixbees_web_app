import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/utils/responsiveLayout.dart';

class LottieGifWidget extends StatefulWidget {
  final String lottiePath;
  final String lottieGifPath;

  const LottieGifWidget({
    Key key,
    this.lottiePath,
    this.lottieGifPath,
  }) : super(key: key);

  @override
  _LottieGifWidgetState createState() => _LottieGifWidgetState();
}

class _LottieGifWidgetState extends State<LottieGifWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    if (ResponsiveLayout.isSmallScreen(context)) {
      // return GifImage(
      //   image: AssetImage(widget.lottieGifPath),
      //   controller: GifController(
      //     vsync: this,Z
      //   ),
      // );
      return ImageWidget(
        imageLocation: widget.lottieGifPath,
      );
    }
    return Lottie.asset(
      widget.lottiePath,
    );
  }
}

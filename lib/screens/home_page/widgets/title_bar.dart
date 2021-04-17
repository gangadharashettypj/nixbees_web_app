import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class TitleBar extends StatefulWidget {
  @override
  _TitleBarState createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with TickerProviderStateMixin {
  AnimationController switchController;
  AnimationController textController;

  @override
  void initState() {
    switchController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000),
    );
    textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      animate();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 100,
          padding: EdgeInsets.only(bottom: 32, left: 8),
          child: Container(
            child: Row(
              children: [
                AnimatedBuilder(
                  builder: (BuildContext context, Widget child) {
                    return Stack(
                      children: [
                        Opacity(
                          child: ImageWidget(
                            imageLocation: MyImages.logo,
                            width: 100,
                          ),
                          opacity: 1 - textController.value ?? 1,
                        ),
                        Opacity(
                          child: ImageWidget(
                            imageLocation: MyImages.neonLogo,
                            width: 100,
                          ),
                          opacity: textController.value ?? 0,
                        ),
                      ],
                    );
                  },
                  animation: Tween(
                    begin: 0.0,
                    end: 1.0,
                  ).animate(
                    textController,
                  ),
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
        ),
        lampSwitch()
      ],
    );
  }

  lampSwitch() {
    return Positioned(
      left: 40,
      top: -22,
      child: Container(
        child: Lottie.asset(
          MyLottieFile.lampSwitch,
          height: 100,
          controller: switchController,
        ),
      ),
    );
  }

  void animate() async {
    await Future.delayed(Duration(milliseconds: 1000));
    switchController.forward();
    await Future.delayed(Duration(milliseconds: 1500));
    await textController.forward();
    await Future.delayed(Duration(milliseconds: 4000));
    switchController.reset();
    textController.reset();
    await Future.delayed(Duration(milliseconds: 1000));
    animate();
  }
}

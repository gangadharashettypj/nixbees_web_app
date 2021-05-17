import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class TitleBar extends StatefulWidget {
  final Function onTap;
  final PageController pageController;
  const TitleBar({
    Key key,
    this.onTap,
    this.pageController,
  }) : super(key: key);
  @override
  _TitleBarState createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with TickerProviderStateMixin {
  AnimationController switchController;
  AnimationController textController;
  String productType;
  String productName;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.pageController.addListener(() {
        setState(() {
          if (widget.pageController.page == 1) {
            productType = HomePage.selectedVariant;
            productName = null;
          } else if (widget.pageController.page == 2) {
            productType = HomePage.selectedVariant;
            productName = HomePage.selectedItem.name;
          } else if (widget.pageController.page == 0) {
            productType = null;
            productName = null;
          }
        });
      });
    });
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: widget.onTap,
            behavior: HitTestBehavior.translucent,
            child: Stack(
              children: [
                Container(
                  height: 100,
                  padding: EdgeInsets.only(bottom: 32, left: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                    ],
                  ),
                ),
                lampSwitch()
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(
            left: 16,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (productName != null || productType != null)
                InkWell(
                  hoverColor: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: MyColors.primary.withAlpha(125),
                  onTap: () {
                    widget.pageController.animateToPage(
                      0,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.ease,
                    );
                  },
                  child: LabelWidget(
                    'Home',
                    color: MyColors.primary,
                    size: TextSize.subTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (productType != null)
                Lottie.asset(
                  MyLottieFile.rightArrow,
                  width: 30,
                  height: 30,
                ),
              if (productType != null)
                InkWell(
                  hoverColor: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: MyColors.primary.withAlpha(125),
                  onTap: () {
                    widget.pageController.animateToPage(
                      1,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.ease,
                    );
                  },
                  child: LabelWidget(
                    productType ?? '',
                    color: MyColors.primary,
                    size: TextSize.subTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (productName != null)
                Lottie.asset(
                  MyLottieFile.rightArrow,
                  width: 30,
                  height: 30,
                ),
              if (productName != null)
                InkWell(
                  hoverColor: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                  splashColor: MyColors.primary.withAlpha(125),
                  onTap: () {},
                  child: LabelWidget(
                    productName ?? '',
                    color: MyColors.primary,
                    size: TextSize.subTitle,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
        ),
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

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/flat_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/common_widgets/scaffold/my_scaffold.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/screens/home_page/widgets/title_bar.dart';
import 'package:payment_gateway/screens/products_page/products_page.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';
import 'package:payment_gateway/utils/responsiveLayout.dart';

class HomePage extends StatefulWidget {
  static const String route = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController manController;
  PageController pageController;
  @override
  void initState() {
    manController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    pageController = PageController(
      keepPage: true,
      initialPage: 0,
    );

    super.initState();
  }

  @override
  void dispose() {
    manController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      body: Stack(
        children: [
          PageView(
            physics: new NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Stack(
                children: [
                  getBanner(),
                  buildScreen(),
                ],
              ),
              ProductsPage(),
            ],
          ),
          TitleBar(
            onTap: () async {
              manController.repeat(reverse: true);
              await pageController.animateToPage(
                0,
                duration: Duration(milliseconds: 1600),
                curve: Curves.ease,
              );
              manController.stop();
              manController.reset();
            },
          ),
          getMan(),
        ],
      ),
    );
  }

  getBanner() {
    return Positioned.fill(
      child: OverflowBox(
        maxHeight: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Lottie.asset(
            MyLottieFile.bannerBackground,
          ),
        ),
      ),
    );
  }

  getMan() {
    return Positioned(
      right: 0,
      bottom: 0,
      height: 70,
      child: Transform.scale(
        scale: 3,
        child: Lottie.asset(
          MyLottieFile.walkingMan,
          controller: manController,
        ),
      ),
    );
  }

  buildMenuBar() {
    return ResponsiveLayout(
      largeScreen: Row(
        children: [
          Expanded(child: Container()),
          FlatButtonWidget(
            title: 'Bulbs',
            onPressed: () async {
              manController.repeat();
              await pageController.animateToPage(
                1,
                duration: Duration(milliseconds: 1600),
                curve: Curves.ease,
              );
              manController.stop();
              manController.reset();
            },
            expanded: false,
            showUnderline: true,
          ),
          FlatButtonWidget(
            title: 'Battens',
            onPressed: () {},
            expanded: false,
            showUnderline: true,
          ),
          FlatButtonWidget(
            title: 'Remote Control Bulbs',
            onPressed: () {},
            expanded: false,
            showUnderline: true,
          ),
          CustomSizedBox.w90,
        ],
      ),
      smallScreen: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: FlatButtonWidget(
          title: 'View Products',
          showUnderline: true,
          onPressed: () {},
          expanded: false,
        ),
      ),
    );
  }

  Widget buildScreen() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(),
          ),
          LabelWidget(
            'Nixbees Lightings',
            fontWeight: FontWeight.bold,
            color: Colors.white,
            size: TextSize.title,
          ),
          CustomSizedBox.h30,
          Container(
            width: 600,
            child: LabelWidget(
              'Nixbees led technology ensures safe and long-lasting light source large illumination area: Lithium ion is maintenance-free meaning it does not require to be re-charged periodically to keep the product alive. Imagine it to be just like your mobile battery, charging it only when you need to.',
              color: Colors.white70,
            ),
          ),
          CustomSizedBox.h30,
          CustomSizedBox.h30,
          buildMenuBar(),
        ],
      ),
    );
  }
}

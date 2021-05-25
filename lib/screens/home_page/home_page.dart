import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/common_widgets/scaffold/my_scaffold.dart';
import 'package:payment_gateway/firebase/firebase_crud.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/screens/home_page/widgets/title_bar.dart';
import 'package:payment_gateway/screens/product_detail/product_detail.dart';
import 'package:payment_gateway/screens/products_page/products_page.dart';
import 'package:payment_gateway/screens/products_page/products_page_controller.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class HomePage extends StatefulWidget {
  static const String route = '/homePage';
  static String selectedVariant;
  static ProductItem selectedItem;
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
            controller: pageController,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  getBanner(),
                  buildScreen(),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                child: ProductsPage(
                  onBuyItem: (item) {
                    HomePage.selectedItem = item;
                    // manController.repeat();
                    pageController.animateToPage(
                      2,
                      duration: Duration(milliseconds: 1500),
                      curve: Curves.ease,
                    );
                    // manController.reset();
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 100),
                child: ProductDetail(
                  onDone: (paymentModel) async {
                    await FirebaseCrud.instance.set(
                      'transactions/${paymentModel.orderID}',
                      paymentModel.toJson(),
                    );
                    pageController.jumpToPage(0);
                  },
                ),
              ),
              // Container(
              //   child: Center(
              //     child: LabelWidget(
              //       'Checking',
              //       color: Colors.white,
              //     ),
              //   ),
              // )
            ],
          ),
          TitleBar(
            pageController: pageController,
            onTap: () async {
              manController.repeat(reverse: true);
              pageController.jumpToPage(
                0,
              );
              manController.stop();
              manController.reset();
            },
          ),
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
    return FutureBuilder(
      future: ProductsPageController.instance.getProductsVariants(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            width: double.infinity,
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: List.generate(
                ProductsPageController.instance.productVariants.length,
                (index) {
                  return InkWell(
                    hoverColor: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                    splashColor: MyColors.primary.withAlpha(125),
                    onTap: () {
                      HomePage.selectedVariant = ProductsPageController
                          .instance.productVariants[index].id;
                      // manController.repeat();
                      pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 1500),
                        curve: Curves.ease,
                      );
                      // manController.reset();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          LabelWidget(
                            ProductsPageController
                                .instance.productVariants[index].name,
                            color: MyColors.primary,
                            size: TextSize.subTitle,
                            fontWeight: FontWeight.bold,
                          ),
                          CustomSizedBox.w6,
                          Lottie.asset(
                            MyLottieFile.rightArrow,
                            width: 35,
                            height: 35,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return Container();
      },
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

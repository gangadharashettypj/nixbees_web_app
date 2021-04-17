import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/scaffold/my_scaffold.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/payment_util.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/screens/home_page/widgets/title_bar.dart';

class HomePage extends StatefulWidget {
  static const String route = '/homePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController manController;
  @override
  void initState() {
    manController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
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
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    getBanner(),
                    getMan(),
                    TitleBar(),
                  ],
                ),
              ),
              Body(),
            ],
          ),
        ),
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
      right: -50,
      bottom: -70,
      child: Stack(
        children: [
          Lottie.asset(
            MyLottieFile.walkingMan,
            controller: manController,
            width: 320,
          ),
          Positioned(
            bottom: 80,
            child: Container(
              height: 50,
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                child: Text('Pay'),
                onPressed: () async {
                  manController.repeat();
                  Future.delayed(Duration(milliseconds: 2000), () {
                    manController.reset();
                    if (kIsWeb)
                      PaymentUtil.instance.makeWebPayment(
                        PaymentModel(
                          customerEmail: 'gs@gmail.com',
                          customerName: 'Gangadhara',
                          customerPhone: '919916548851',
                          orderAmount: '1',
                          orderNote: 'Note note',
                          stage: PaymentMode.prod,
                        ).toJsonString(),
                      );
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
    // return ResponsiveLayout(
    //   largeScreen: LargeChild(),
    //   smallScreen: SmallChild(),
    // );
  }
}

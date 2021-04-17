import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/scaffold/my_scaffold.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/payment_util.dart';
import 'package:payment_gateway/resources/images.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/screens/home_page/widgets/title_bar.dart';
import 'package:payment_gateway/utils/responsiveLayout.dart';

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
      child: Lottie.asset(
        MyLottieFile.bannerBackground,
        fit: BoxFit.cover,
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
    return ResponsiveLayout(
      largeScreen: LargeChild(),
      smallScreen: SmallChild(),
    );
  }
}

class LargeChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            alignment: Alignment.centerRight,
            widthFactor: .6,
            child: Image.network(MyImages.bannerBackground, scale: .85),
          ),
          FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: .6,
            child: Padding(
              padding: EdgeInsets.only(left: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Hello!",
                      style: TextStyle(
                          fontSize: 60,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat-Regular",
                          color: Color(0xFF8591B0))),
                  RichText(
                    text: TextSpan(
                        text: "WellCome To ",
                        style:
                            TextStyle(fontSize: 60, color: Color(0xFF8591B0)),
                        children: [
                          TextSpan(
                              text: "Britu",
                              style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87))
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 20),
                    child: Text("LET’S EXPLORE THE WORLD"),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SmallChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Hello!",
              style: TextStyle(
                  fontSize: 40,
                  color: Color(0xFF8591B0),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat-Regular"),
            ),
            RichText(
              text: TextSpan(
                text: 'WellCome To ',
                style: TextStyle(fontSize: 40, color: Color(0xFF8591B0)),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Britu',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.black87)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 20),
              child: Text("LET’S EXPLORE THE WORLD"),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Image.network(
                MyImages.bannerBackground,
                scale: 1,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

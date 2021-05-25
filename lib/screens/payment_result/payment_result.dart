import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/navigator/navigator.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/resources/lotties.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/screens/home_page/widgets/title_bar.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';

class PaymentResult extends StatefulWidget {
  final String orderId;

  const PaymentResult({
    Key key,
    this.orderId,
  }) : super(key: key);
  @override
  _PaymentResultState createState() => _PaymentResultState();
}

class _PaymentResultState extends State<PaymentResult> {
  PaymentResponseModel response;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseDatabase.instance
          .reference()
          .child('transactions')
          .child(widget.orderId)
          .onValue
          .listen((event) {
        setState(() {
          response = PaymentResponseModel.fromJson(event.snapshot.value);
        });
      });
    });
    super.initState();
  }

  bool isPaymentDataUpdated() {
    return true;
  }

  String getStatusMessage() {
    if (response.txStatus != null && response.txStatus.isNotEmpty) {
      return response.txMsg;
    }
    return 'Checking payment status';
  }

  String getStatusSubMessage() {
    if (response.txStatus != null && response.txStatus.isNotEmpty) {
      if (response.txStatus == 'SUCCESS') {
        return '₹${response.orderAmount}\n\nThank you, we have received your order!\n\nPlease note down Your Order Id `${response.orderId}` for further reference\n\Check your email for receipt';
      } else {
        return response.txMsg;
      }
    }
    return '';
  }

  Widget buildNoDataView() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            MyLottieFile.loader,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          LabelWidget(
            'Checking payment status...',
            color: MyColors.primary,
            size: 20,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget buildSuccessView() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            MyLottieFile.paymentSuccess,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          LabelWidget(
            response.txMsg ?? '',
            color: Colors.green,
            size: 24,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          CustomSizedBox.h18,
          LabelWidget(
            '₹${response.orderAmount}',
            color: Colors.white,
            size: 30,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          CustomSizedBox.h18,
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: RichText(
              text: TextSpan(
                text:
                    'Thank you, we have received your order !\n\nPlease note down Your Order Id   ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
                children: [
                  TextSpan(
                    text: response.orderId,
                    style: TextStyle(
                      color: MyColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  TextSpan(
                    text:
                        '   for further reference.\n\nCheck your mail for your receipt.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFailedView() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            MyLottieFile.paymentFailed,
            height: MediaQuery.of(context).size.height * 0.2,
          ),
          CustomSizedBox.h12,
          LabelWidget(
            response.txMsg ?? '',
            color: Colors.red,
            size: 24,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          CustomSizedBox.h18,
          LabelWidget(
            '₹${response.orderAmount}',
            color: Colors.white,
            size: 30,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center,
          ),
          CustomSizedBox.h18,
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: LabelWidget(
              'Unfortunately your payment request could not be completed. Please try again.',
              color: Colors.white,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildScreen() {
    if (response == null) {
      return Center(
        child: Lottie.asset(
          MyLottieFile.loader,
          height: MediaQuery.of(context).size.height * 0.2,
        ),
      );
    }
    if (response.txStatus == null) {
      return buildNoDataView();
    } else if (response.txStatus == 'SUCCESS') {
      return buildSuccessView();
    } else {
      return buildFailedView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          buildScreen(),
          TitleBar(
            onTap: () async {
              NavigationService.instance
                  .pushReplacement(context, HomePage.route);
            },
          ),
        ],
      ),
    );
  }
}

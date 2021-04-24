import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/button_widget.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';

class ProductItemWidget extends StatelessWidget {
  final ProductItem item;
  final Function onBuy;
  const ProductItemWidget({
    Key key,
    this.item,
    this.onBuy,
  }) : super(key: key);

  Widget buildCard() {
    return Container(
      width: 300,
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      margin: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 20, 20, 20),
            Color.fromARGB(255, 46, 46, 46),
            Color.fromARGB(255, 96, 96, 96),
          ],
          tileMode: TileMode.mirror,
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ImageWidget(
              imageLocation: item.url,
              height: 150,
            ),
          ),
          CustomSizedBox.h30,
          Center(
            child: LabelWidget(
              item.name,
              size: TextSize.subTitle1,
              color: Colors.white,
            ),
          ),
          CustomSizedBox.h12,
          LabelWidget(
            item.description,
            size: TextSize.h6,
          ),
          CustomSizedBox.h24,
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              LabelWidget(
                '₹ ${item.price ?? ''}/-',
                size: TextSize.h6,
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.lineThrough,
              ),
              CustomSizedBox.w12,
              LabelWidget(
                '₹ ${item.offerPrice ?? ''}/-',
                size: TextSize.subTitle,
                color: MyColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          CustomSizedBox.h18,
        ],
      ),
    );
  }

  Widget buildBuyButton(BuildContext context) {
    return ButtonWidget(
      title: 'Buy',
      onPressed: onBuy,
      expanded: false,
      color: MyColors.primary,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 18),
          child: buildCard(),
        ),
        buildBuyButton(context),
      ],
    );
  }
}

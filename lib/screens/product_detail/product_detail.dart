import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/button_widget.dart';
import 'package:payment_gateway/common_widgets/icon_widget.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/common_widgets/textfield_widget.dart';
import 'package:payment_gateway/models.dart';
import 'package:payment_gateway/payment_util.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';
import 'package:payment_gateway/utils/responsiveLayout.dart';
import 'package:payment_gateway/utils/validators.dart';

class ProductDetail extends StatefulWidget {
  static const String route = '/productDetail';
  final void Function(PaymentModel) onDone;

  const ProductDetail({
    Key key,
    @required this.onDone,
  }) : super(key: key);
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  PageController mediaController;
  int selectedMedia = 0;
  final _formKey = GlobalKey<FormState>();
  int numberOfProduct = 1;

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  void _buyProduct() async {
    if (_formKey.currentState.validate()) {
      if (kIsWeb) {
        final model = PaymentModel(
          customerEmail: email.text,
          customerName: name.text,
          customerPhone: '91${phone.text}',
          orderAmount:
              ((HomePage.selectedItem.offerPrice * numberOfProduct) + 60)
                  .toString(),
          orderNote: address.text ?? '',
          stage: PaymentMode.test,
          orderId: DateTime.now().millisecondsSinceEpoch.toString(),
          numberOfProducts: numberOfProduct,
          productName: HomePage.selectedItem.name,
          productType: HomePage.selectedVariant,
        );
        print(model.toJsonString());
        await PaymentUtil.instance.makeWebPayment(
          model.toJsonString(),
        );
        widget.onDone?.call(model);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaController ??= PageController(viewportFraction: 0.2, initialPage: 0);
    return ResponsiveLayout(
      largeScreen: Container(
        padding: EdgeInsets.all(32),
        child: buildDetailLargeScreen(),
      ),
      mediumScreen: Container(
        padding: EdgeInsets.all(32),
        child: buildDetailLargeScreen(),
      ),
      smallScreen: Container(
        padding: EdgeInsets.all(16),
        child: buildDetailSmallScreen(),
      ),
    );
  }

  Widget buildDetailSmallScreen() {
    return Container(
      margin: EdgeInsets.only(top: 44),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: ListView(
        cacheExtent: 1000,
        children: [
          buildMobileMediaSliderWidget(),
          CustomSizedBox.h30,
          buildDetailsWidget(),
          CustomSizedBox.h30,
          buildSpecWidget(),
          CustomSizedBox.h30,
          buildMobileCheckoutWidget(),
        ],
      ),
    );
  }

  Widget buildDetailLargeScreen() {
    return Container(
      margin: EdgeInsets.only(top: 44),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              children: [
                buildWebMediaSliderWidget(),
                CustomSizedBox.h30,
                buildDetailsWidget(),
              ],
            ),
          ),
          CustomSizedBox.w30,
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: buildSpecWidget(),
                  ),
                ),
                CustomSizedBox.h12,
                Expanded(
                  child: SingleChildScrollView(
                    child: buildWebCheckoutWidget(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebCheckoutWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LabelWidget(
            'Fill the form to buy',
            fontWeight: FontWeight.bold,
            size: 30,
            color: Colors.white,
          ),
          CustomSizedBox.h30,
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    TextFieldWidget(
                      hintText: 'Full name',
                      placeholder: 'ex: Mr. John',
                      size: 16,
                      initialValue: name.text,
                      counterText: '',
                      maxLength: 20,
                      onChanged: (val) {
                        name.text = val;
                      },
                      validator: (val) {
                        if (val.isEmpty || val.length < 3) {
                          return 'Enter a valid name';
                        }
                        return null;
                      },
                    ),
                    CustomSizedBox.h30,
                    TextFieldWidget(
                      hintText: 'Email',
                      placeholder: 'ex: abcd@email.com',
                      size: 16,
                      textInputType: TextInputType.emailAddress,
                      initialValue: email.text,
                      onChanged: (val) {
                        email.text = val;
                      },
                      validator: (val) {
                        if (Validators.emailValidator(val)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    CustomSizedBox.h30,
                    TextFieldWidget(
                      hintText: 'Phone',
                      placeholder: 'ex: 9999999999',
                      size: 16,
                      textInputType: TextInputType.number,
                      initialValue: phone.text,
                      maxLength: 10,
                      counterText: '',
                      onChanged: (val) {
                        phone.text = val;
                      },
                      validator: (val) {
                        if (val.isEmpty || val.length < 10) {
                          return 'Enter a valid phone number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              CustomSizedBox.w30,
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    TextFieldWidget(
                      hintText: 'Address',
                      placeholder: 'ex: write the address to be delivered',
                      size: 16,
                      numberOfLine: 3,
                      textInputType: TextInputType.streetAddress,
                      initialValue: address.text,
                      onChanged: (val) {
                        address.text = val;
                      },
                      validator: (val) {
                        if (val.isEmpty || val.length < 10) {
                          return 'Enter a valid address';
                        }
                        return null;
                      },
                    ),
                    CustomSizedBox.h30,
                    Row(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: numberOfProduct == 1
                                        ? Colors.white54
                                        : MyColors.primary,
                                  ),
                                  onPressed: () {
                                    if (numberOfProduct <= 1) {
                                      return;
                                    }
                                    setState(() {
                                      numberOfProduct--;
                                    });
                                  },
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: numberOfProduct == 1
                                        ? Colors.white54
                                        : MyColors.primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              CustomSizedBox.w30,
                              LabelWidget(
                                '${numberOfProduct ?? ''}',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                size: 16,
                              ),
                              CustomSizedBox.w30,
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: numberOfProduct == 5
                                        ? Colors.white54
                                        : MyColors.primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: numberOfProduct == 5
                                        ? Colors.white54
                                        : MyColors.primary,
                                  ),
                                  onPressed: () {
                                    if (numberOfProduct >= 5) {
                                      return;
                                    }
                                    setState(() {
                                      numberOfProduct++;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            LabelWidget(
                              '* 60₹ for delivery charges',
                              color: Colors.white,
                            ),
                            CustomSizedBox.h18,
                            ButtonWidget(
                              title:
                                  'Buy @ ₹${(HomePage.selectedItem.offerPrice * numberOfProduct) + 60}',
                              onPressed: _buyProduct,
                              expanded: ResponsiveLayout.isSmallScreen(context)
                                  ? true
                                  : false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMobileCheckoutWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LabelWidget(
            'Fill the form to buy',
            fontWeight: FontWeight.bold,
            size: 30,
            color: Colors.white,
          ),
          CustomSizedBox.h30,
          TextFieldWidget(
            hintText: 'Full name',
            placeholder: 'ex: Mr. John',
            size: 16,
            counterText: '',
            initialValue: name.text,
            maxLength: 20,
            onChanged: (val) {
              name.text = val;
            },
            validator: (val) {
              if (val.isEmpty || val.length < 3) {
                return 'Enter a valid name';
              }
              return null;
            },
          ),
          CustomSizedBox.h30,
          TextFieldWidget(
            hintText: 'Email',
            placeholder: 'ex: abcd@email.com',
            size: 16,
            textInputType: TextInputType.emailAddress,
            initialValue: email.text,
            onChanged: (val) {
              email.text = val;
            },
            validator: (val) {
              if (Validators.emailValidator(val)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          CustomSizedBox.h30,
          TextFieldWidget(
            hintText: 'Phone',
            placeholder: 'ex: 9999999999',
            size: 16,
            counterText: '',
            textInputType: TextInputType.number,
            initialValue: phone.text,
            maxLength: 10,
            onChanged: (val) {
              phone.text = val;
            },
            validator: (val) {
              if (val.isEmpty || val.length < 10) {
                return 'Enter a valid phone number';
              }
              return null;
            },
          ),
          CustomSizedBox.h30,
          TextFieldWidget(
            hintText: 'Address',
            placeholder: 'ex: write the address to be delivered',
            size: 16,
            numberOfLine: 3,
            textInputType: TextInputType.streetAddress,
            initialValue: address.text,
            onChanged: (val) {
              address.text = val;
            },
            validator: (val) {
              if (val.isEmpty || val.length < 10) {
                return 'Enter a valid address';
              }
              return null;
            },
          ),
          CustomSizedBox.h30,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: IconButton(
                  icon: Icon(
                    Icons.remove,
                    color: numberOfProduct == 1
                        ? Colors.white54
                        : MyColors.primary,
                  ),
                  onPressed: () {
                    if (numberOfProduct <= 1) {
                      return;
                    }
                    setState(() {
                      numberOfProduct--;
                    });
                  },
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: numberOfProduct == 1
                        ? Colors.white54
                        : MyColors.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              CustomSizedBox.w30,
              LabelWidget(
                '${numberOfProduct ?? ''}',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                size: 16,
              ),
              CustomSizedBox.w30,
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: numberOfProduct == 5
                        ? Colors.white54
                        : MyColors.primary,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.add,
                    color: numberOfProduct == 5
                        ? Colors.white54
                        : MyColors.primary,
                  ),
                  onPressed: () {
                    if (numberOfProduct >= 5) {
                      return;
                    }
                    setState(() {
                      numberOfProduct++;
                    });
                  },
                ),
              ),
            ],
          ),
          CustomSizedBox.h30,
          LabelWidget(
            '* 60₹ for delivery charges',
            color: Colors.white,
          ),
          CustomSizedBox.h12,
          Container(
            padding: EdgeInsets.all(8),
            child: ButtonWidget(
              title:
                  'Buy @ ₹${(HomePage.selectedItem.offerPrice * numberOfProduct) + 60}',
              onPressed: _buyProduct,
              expanded: ResponsiveLayout.isSmallScreen(context) ? true : false,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebMediaSliderWidget() {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: ImageWidget(
              imageLocation: HomePage.selectedItem.media.images[selectedMedia],
            ),
          ),
          CustomSizedBox.h18,
          Container(
            height: 80,
            child: Row(
              children: [
                IconWidget(
                  icon: Icons.chevron_left_rounded,
                  color: MyColors.primary,
                  backgroundColor: Colors.transparent,
                  depth: 0,
                ),
                CustomSizedBox.w12,
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedMedia = index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: selectedMedia == index
                                    ? MyColors.primary
                                    : Colors.black,
                                width: 2,
                              ),
                            ),
                            child: ImageWidget(
                              imageLocation:
                                  HomePage.selectedItem.media.images[index],
                            ),
                            padding: EdgeInsets.all(4),
                          ),
                        ),
                      );
                    },
                    itemCount: HomePage.selectedItem.media.images.length,
                  ),
                ),
                CustomSizedBox.w12,
                IconWidget(
                  icon: Icons.chevron_right_rounded,
                  color: MyColors.primary,
                  backgroundColor: Colors.transparent,
                  depth: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMobileMediaSliderWidget() {
    return Column(
      children: [
        ImageWidget(
          imageLocation: HomePage.selectedItem.media.images[selectedMedia],
          boxFit: BoxFit.contain,
        ),
        CustomSizedBox.h18,
        Container(
          height: 80,
          child: Row(
            children: [
              IconWidget(
                icon: Icons.chevron_left_rounded,
                color: MyColors.primary,
                backgroundColor: Colors.transparent,
                depth: 0,
              ),
              CustomSizedBox.w12,
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedMedia = index;
                        });
                      },
                      child: Container(
                        height: 80,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: selectedMedia == index
                                  ? MyColors.primary
                                  : Colors.black,
                              width: 2,
                            ),
                          ),
                          child: ImageWidget(
                            imageLocation:
                                HomePage.selectedItem.media.images[index],
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: HomePage.selectedItem.media.images.length,
                ),
              ),
              CustomSizedBox.w12,
              IconWidget(
                icon: Icons.chevron_right_rounded,
                color: MyColors.primary,
                backgroundColor: Colors.transparent,
                // onTap: () {
                //   setState(() {
                //     selectedMedia++;
                //     if (selectedMedia >
                //         (HomePage.selectedItem.media.images.length -
                //             1)) {
                //       selectedMedia =
                //           HomePage.selectedItem.media.images.length -
                //               1;
                //     }
                //   });
                // },
                depth: 0,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSpecWidget() {
    return Container(
      width: double.infinity,
      child: DataTable(
        columnSpacing: 16.0,
        rows: List.generate(
          HomePage.selectedItem.spec.length,
          (index) => DataRow(
            cells: [
              DataCell(
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        width: 8,
                        height: 8,
                        color: Colors.white,
                      ),
                    ),
                    CustomSizedBox.w12,
                    LabelWidget(
                      HomePage.selectedItem.spec[index].title,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
              DataCell(
                LabelWidget(
                  HomePage.selectedItem.spec[index].desc,
                  textAlign: TextAlign.start,
                  color: Colors.white54,
                ),
              ),
            ],
          ),
        ),
        columns: [
          DataColumn(
            label: LabelWidget(
              'Specifications',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              size: TextSize.subTitle1,
            ),
          ),
          DataColumn(
            label: LabelWidget(
              '',
              fontWeight: FontWeight.bold,
              color: Colors.white,
              size: TextSize.subTitle1,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDetailsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: LabelWidget(
            HomePage.selectedItem.name,
            fontWeight: FontWeight.bold,
            size: TextSize.subTitle1,
            color: MyColors.primary,
          ),
        ),
        CustomSizedBox.h30,
        LabelWidget(
          HomePage.selectedItem.description,
          size: TextSize.subTitle,
          color: Colors.white70,
        ),
        CustomSizedBox.h30,
      ],
    );
  }

  Map<String, String> getSpecList() {
    Map<String, String> data = {};
    HomePage.selectedItem.spec.forEach((element) {
      data[element.title] = element.desc;
    });
    return data;
  }
}

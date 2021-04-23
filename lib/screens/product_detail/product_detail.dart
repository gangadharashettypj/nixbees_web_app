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
  final Function onDone;

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

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

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
        children: [
          buildMediaSliderWidget(),
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
            flex: 4,
            child: Column(
              children: [
                buildMediaSliderWidget(),
                CustomSizedBox.h30,
                Expanded(
                  child: ListView(
                    children: [
                      buildDetailsWidget(),
                      buildSpecWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CustomSizedBox.w120,
          Expanded(
            flex: 8,
            child: buildWebCheckoutWidget(),
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
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                TextFieldWidget(
                  hintText: 'Full name',
                  placeholder: 'ex: Mr. John',
                  size: 16,
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
                  placeholder:
                      'ex: near abc school, 1st main, 2nd road, mg road, bangalore',
                  size: 16,
                  numberOfLine: 5,
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
              ],
            ),
          ),
          ButtonWidget(
            title: 'Buy',
            onPressed: () async {
              if (_formKey.currentState.validate()) {
                if (kIsWeb) {
                  await PaymentUtil.instance.makeWebPayment(
                    PaymentModel(
                      customerEmail: email.text,
                      customerName: name.text,
                      customerPhone: '91${phone.text}',
                      orderAmount: '1',
                      orderNote: 'Buying ${HomePage.selectedItem.name}',
                      stage: PaymentMode.prod,
                    ).toJsonString(),
                  );
                }
              }
            },
            expanded: ResponsiveLayout.isSmallScreen(context) ? true : false,
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
          TextFieldWidget(
            hintText: 'Full name',
            placeholder: 'ex: Mr. John',
            size: 16,
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
            placeholder:
                'ex: near abc school, 1st main, 2nd road, mg road, bangalore',
            size: 16,
            numberOfLine: 5,
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
          Container(
            padding: EdgeInsets.all(8),
            child: ButtonWidget(
              title: 'Buy',
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  if (kIsWeb) {
                    await PaymentUtil.instance.makeWebPayment(
                      PaymentModel(
                        customerEmail: email.text,
                        customerName: name.text,
                        customerPhone: '91${phone.text}',
                        orderAmount: '1',
                        orderNote: 'Buying ${HomePage.selectedItem.name}',
                        stage: PaymentMode.prod,
                      ).toJsonString(),
                    );
                    widget.onDone?.call();
                  }
                }
              },
              expanded: ResponsiveLayout.isSmallScreen(context) ? true : false,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMediaSliderWidget() {
    return Column(
      children: [
        ImageWidget(
          imageLocation: HomePage.selectedItem.media.images[selectedMedia],
          height: MediaQuery.of(context).size.height * 0.3,
          boxFit: BoxFit.contain,
        ),
        CustomSizedBox.h18,
        Container(
          height: 80,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Colors.white,
            ),
          ),
          child: Row(
            children: [
              IconWidget(
                icon: Icons.chevron_left_rounded,
                color: MyColors.primary,
                backgroundColor: Colors.transparent,
                // onTap: () {
                //   setState(() {
                //     selectedMedia--;
                //     if (selectedMedia < 0) {
                //       selectedMedia = 0;
                //     }
                //   });
                // },
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
                        height: 100,
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          children: [
                            Container(
                              color: selectedMedia == index
                                  ? MyColors.primary
                                  : null,
                              child: ImageWidget(
                                imageLocation:
                                    HomePage.selectedItem.media.images[index],
                              ),
                              padding: EdgeInsets.all(4),
                            ),
                          ],
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
            size: TextSize.title,
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

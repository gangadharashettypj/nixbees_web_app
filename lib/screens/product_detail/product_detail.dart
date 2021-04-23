import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/icon_widget.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';
import 'package:payment_gateway/theme/sizes.dart';
import 'package:payment_gateway/utils/responsiveLayout.dart';

class ProductDetail extends StatefulWidget {
  static const String route = '/productDetail';

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  PageController mediaController;
  int selectedMedia = 0;
  @override
  void initState() {
    super.initState();
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            buildMediaSliderWidget(),
            CustomSizedBox.h30,
            buildDetailsWidget(),
            CustomSizedBox.h30,
            buildSpecWidget(),
            CustomSizedBox.h30,
            Container(),
          ],
        ),
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
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: buildMediaSliderWidget(),
                ),
                CustomSizedBox.w60,
                Expanded(
                  flex: 5,
                  child: buildDetailsWidget(),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: buildSpecWidget(),
                ),
                Expanded(
                  flex: 5,
                  child: Container(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMediaSliderWidget() {
    return Column(
      children: [
        ImageWidget(
          imageLocation: HomePage.selectedItem.media.images[selectedMedia],
          height: MediaQuery.of(context).size.height * 0.4,
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
                LabelWidget(
                  HomePage.selectedItem.spec[index].title,
                  color: Colors.white54,
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
        DataTable(
          columnSpacing: 16.0,
          rows: List.generate(
            HomePage.selectedItem.features.length,
            (index) => DataRow(
              cells: [
                DataCell(
                  ImageWidget(
                    imageLocation: HomePage.selectedItem.features[index].image,
                    width: 100,
                    height: 50,
                  ),
                ),
                DataCell(
                  LabelWidget(
                    HomePage.selectedItem.features[index].title,
                    color: Colors.white54,
                  ),
                ),
              ],
            ),
          ),
          columns: [
            DataColumn(
              label: LabelWidget(
                'Features',
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
              ),
            ),
          ],
        ),
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

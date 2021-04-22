import 'package:flutter/material.dart';
import 'package:payment_gateway/common_widgets/icon_widget.dart';
import 'package:payment_gateway/common_widgets/image_widget.dart';
import 'package:payment_gateway/resources/colors.dart';
import 'package:payment_gateway/screens/home_page/home_page.dart';
import 'package:payment_gateway/simplifiers/sized_box.dart';

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
    return Container(
      padding: EdgeInsets.all(32),
      child: buildDetailScreen(),
    );
  }

  Widget buildDetailScreen() {
    return Container(
      margin: EdgeInsets.only(top: 44),
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [buildMediaSliderWidget()],
        ),
      ),
    );
  }

  final List<Widget> imageSliders =
      List.generate(HomePage.selectedItem.media.images.length, (index) => index)
          .map(
            (item) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: ImageWidget(
                imageLocation: HomePage.selectedItem.media.images[item],
                boxFit: BoxFit.cover,
                width: 1000.0,
              ),
            ),
          )
          .toList();

  double getMediaSliderWidth() {
    double width = MediaQuery.of(context).size.width;
    if (width < 500)
      return width;
    else if (width < 800)
      return width * 0.5;
    else
      return width * 0.4;
  }

  Widget buildMediaSliderWidget() {
    return Container(
      width: getMediaSliderWidth(),
      child: Column(
        children: [
          ImageWidget(
            imageLocation: HomePage.selectedItem.media.images[selectedMedia],
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          CustomSizedBox.h18,
          Container(
            height: 80,
            child: Row(
              children: [
                if (selectedMedia > 0)
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
                if (selectedMedia == 0) CustomSizedBox.w60,
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
                if (selectedMedia ==
                    (HomePage.selectedItem.media.images.length - 1))
                  CustomSizedBox.w60,
                if (selectedMedia <
                    (HomePage.selectedItem.media.images.length - 1))
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
      ),
    );
  }
}

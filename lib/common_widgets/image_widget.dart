/*
 * @Author GS
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:payment_gateway/common_widgets/circular_progress_indicator.dart';

enum ImageType { asset, network }

class ImageWidget extends StatelessWidget {
  final bool isSvg;
  final double height;
  final double width;
  final BoxFit boxFit;
  final ImageType imageType;
  final String imageLocation;
  final Color color;
  final PlaceholderWidgetBuilder placeholderWidgetBuilder;
  final LoadingErrorWidgetBuilder errorWidgetBuilder;

  ImageWidget({
    this.boxFit = BoxFit.contain,
    @required this.imageLocation,
    this.height,
    this.width,
    this.color,
    this.placeholderWidgetBuilder,
    this.errorWidgetBuilder,
  })  : imageType = imageLocation.trim().startsWith('assets/')
            ? ImageType.asset
            : ImageType.network,
        isSvg = imageLocation.trim().startsWith('assets/')
            ? imageLocation.endsWith('\.svg')
            : Uri.parse(imageLocation).path.endsWith('\.svg');

  @override
  Widget build(BuildContext context) {
    if (isSvg) {
      switch (imageType) {
        case ImageType.asset:
          return SvgPicture.asset(
            imageLocation,
            height: height,
            width: width,
            fit: boxFit,
            color: color,
          );
        case ImageType.network:
          return SvgPicture.network(
            imageLocation,
            height: height,
            width: width,
            fit: boxFit,
            color: color,
          );
      }
    } else {
      switch (imageType) {
        case ImageType.asset:
          return Image.asset(
            imageLocation,
            height: height,
            width: width,
            fit: boxFit,
            color: color,
          );

        case ImageType.network:
          return CachedNetworkImage(
            width: width,
            height: height,
            imageUrl: imageLocation,
            fit: boxFit,
            color: color,
            placeholder: placeholderWidgetBuilder ??
                (_, __) => Container(
                      height: height ?? 100,
                      width: width ?? 100,
                      child: CircularProgressIndicatorWidget(),
                    ),
            errorWidget: errorWidgetBuilder,
          );
      }
    }
    return Container();
  }
}

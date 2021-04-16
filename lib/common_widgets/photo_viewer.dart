/*
 * @Author GS
 */
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:payment_gateway/navigator/navigator.dart';
import 'package:photo_view/photo_view.dart';

class PhotoViewerArgs {
  String imageUrl;
  Function onChangeClicked;
  Image image;
  Uint8List imageBytes;

  PhotoViewerArgs({
    this.imageUrl,
    this.onChangeClicked,
    this.image,
    this.imageBytes,
  });
}

class PhotoViewer extends StatefulWidget {
  final PhotoViewerArgs photoViewerArgs;
  static const String route = '/photoViewer';

  PhotoViewer({@required this.photoViewerArgs});

  @override
  _PhotoViewerState createState() => _PhotoViewerState();
}

class _PhotoViewerState extends State<PhotoViewer> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 32,
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ),
                onPressed: () {
                  NavigationService.instance.pop(context);
                },
              ),
              // Expanded(
              //   child: Container(),
              // ),
              // FlatButton(
              //   child: Text(
              //     'Change Image',
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              //   onPressed: () {
              //     if (widget.photoViewerArgs.onChangeClicked != null) {
              //       NavigationService.instance.pop(context);
              //       widget.photoViewerArgs.onChangeClicked?.call();
              //     }
              //   },
              // ),
            ],
          ),
          Expanded(
            child: Container(
              child: PhotoView(
                imageProvider: widget.photoViewerArgs.imageUrl != null
                    ? CachedNetworkImageProvider(
                        widget.photoViewerArgs.imageUrl,
                      )
                    : widget.photoViewerArgs?.image?.image,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

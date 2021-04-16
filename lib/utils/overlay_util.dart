/*
 * @Author GS
 */
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:payment_gateway/common_widgets/data_overlay_modal.dart';
import 'package:payment_gateway/common_widgets/label_widget.dart';
import 'package:payment_gateway/navigator/navigator.dart';
import 'package:payment_gateway/resources/colors.dart';

Future<dynamic> openCustomOverlay(
  BuildContext context, {
  @required Widget child,
  bool isDismissible,
  bool enableDrag,
  bool isExpanded = false,
}) async {
  return await showMaterialModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0),
      ),
    ),
    expand: isExpanded,
    duration: Duration(milliseconds: 800),
    context: context,
    builder: (context) => child,
    backgroundColor: MyColors.neuBackground,
    isDismissible: false,
    enableDrag: false,
    barrierColor: Colors.black26,
  );
}

Future<bool> showPermissionOverlay(BuildContext context,
    {String title,
    String description,
    String positiveText = 'OK',
    String negativeText = 'CANCEL'}) async {
  return await openCustomOverlay(
    context,
    child: OverlayModal(
      title: title ?? 'Alert!',
      child: Container(
        padding: EdgeInsets.all(32),
        child: LabelWidget(
          description ?? '',
        ),
      ),
      leftButtonText: negativeText,
      rightButtonText: positiveText,
      onLeftButtonPressed: () async {
        NavigationService.instance.pop(
          context,
          arguments: false,
        );
      },
      onRightButtonPressed: () async {
        NavigationService.instance.pop(
          context,
          arguments: true,
        );
      },
      closeOnButtonPress: false,
    ),
    isDismissible: false,
    enableDrag: false,
  );
}

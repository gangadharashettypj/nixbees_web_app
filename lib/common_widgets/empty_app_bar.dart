/*
 * @Author GS
 */
import 'package:flutter/material.dart';
import 'package:payment_gateway/resources/colors.dart';

/*
Used in order to set status bar color as same as scaffold app bar
 */

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container(color: MyColors.neuBackground);
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

/*
 * @Author GS
 */
import 'package:flutter/material.dart';

class MyColors {
  /*
  * Material theme
  */
  static Color get primary => Color.fromARGB(255, 232, 102, 45);
  static Color get primaryDark => Color.fromARGB(255, 46, 46, 46);
  static Color get accent => Color.fromARGB(255, 232, 102, 45);
  static Color get transparent => Colors.transparent;

  /*
  * Neu theme
  */
  static Color get neuBackground => Color(0xFFE3EDF7);
  static Color get neuBackgroundDark => Color(0xFF1D2024);
  static Color get neuBackground1 => Color(0xFFEFE5EC);
  static Color get neuShadowDarkColor => Color.fromARGB(181, 231, 114, 47);
  static Color get neuShadowLightColor => Color.fromARGB(255, 133, 41, 0);

  /*
  * general
  */
  static Color get textColor => Color(0xff606574);
  static Color get textLightColor => Color(0xff878c9d);
  static Color get textDarkColor => Color(0xFF505050);

  static Color get dividerColors => Colors.blueGrey.withAlpha(150);
}

class RawColors {
  //White colors
  static Color whiteSlightDense = Color(0xFFf0f0f5);
  static Color whiteLittleDense = Color(0xFFeaeaf1);
  static Color whiteDense = Color(0xFFe1e1ee);
  static Color whiteDenser = Color(0xFFdedee4);
  static Color whiteVeryDense = Color(0xFFaaaaaa);
  static Color whiteTranslucent = Color(0x66ffffff);

  //grey colors
  static Color dividerColor = Colors.blueGrey.withAlpha(150);
  static Color greyLighter = Color(0xFFBFBFBF);
  static Color greyLight = Color(0xFF606574);
  static Color greyDark = Color(0xFF505050);
  static Color greyTranslucent = Color(0x4C71778f);
  static Color veryDarkGray = Color(0xff4a4a4a);
  static Color grayishBlue = Color(0XFFdde1ea);
  static Color grayDarkBlue = Color(0XFF878c9d);
  static Color lightGreyBlue = Color(0Xffbbbfd4);
  static Color lightGrayishBlue = Color(0xffd4d5de);
  static Color purpleGrey = Color(0xff4c5973);
  static Color silver = Color(0xffD7DDE3);

  //black colors
  static Color blackLighter = Color(0xFF2d2d2d);
  static Color blackLight = Color(0xff212121);
  static Color blackDark = Color(0xff000000);
  static Color blackTranslucent = Colors.black12;
}

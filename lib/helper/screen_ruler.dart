import 'package:flutter/material.dart';

class ScreenSize {
  static final ScreenSize instance = ScreenSize._privateConstructor();
  ScreenSize._privateConstructor();

  double paddingTop;
  double paddingBottom;
  double screenWidth;
  double screenHeight;

  setSizes(BuildContext context) {
    paddingTop = MediaQuery.of(context).padding.top;
    paddingBottom = MediaQuery.of(context).padding.bottom;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }
}
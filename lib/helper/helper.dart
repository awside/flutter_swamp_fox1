import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

statusBarLight() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
      .copyWith(statusBarIconBrightness: Brightness.light));
}

statusBarDark() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
      .copyWith(statusBarIconBrightness: Brightness.dark));
}

Rect dimensionsOf(BuildContext context) {
  return context?.findRenderObject()?.paintBounds;
}

double getScrollPosition(ScrollController controller) {
  return controller.position.pixels;
}
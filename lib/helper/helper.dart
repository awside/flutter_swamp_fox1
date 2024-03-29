import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/rendering.dart';
import 'package:yaml/yaml.dart';

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

Map<String, dynamic> getJsonFromString(String data) {
  return json.decode(data);
}

List<dynamic> getYamlDocumentsFromString(String data) {
  var yamlDocList = loadYamlDocuments(data);
  var docList = <dynamic>[];
  for (var yamlDoc in yamlDocList) {
    docList.add(yamlDoc.contents.value);
  }
  return docList;
}

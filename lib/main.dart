import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';

import 'package:swamp_fox/app.dart';
import 'package:swamp_fox/helper/helper.dart';

void main() async {
  // debugPaintPointersEnabled = true;
  statusBarDark();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

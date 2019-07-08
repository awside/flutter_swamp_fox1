import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:swamp_fox/helper/helper.dart' as MyHelper;
import 'package:swamp_fox/pages/listPage.dart';
import 'package:swamp_fox/renderers/listRenderer.dart';
import 'package:swamp_fox/topics/topicsLoader.dart' show TopicsLoader;
import 'package:swamp_fox/widgets/bottomBar.dart' as MyBottomBar;
import 'package:swamp_fox/widgets/statusBar.dart';
import 'package:swamp_fox/widgets/topBar.dart';

void main() async {
  await TopicsLoader.instance.load();

  // debugPaintPointersEnabled = true;
  MyHelper.statusBarDark();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(new Start());
}

class Start extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
            // title: TextStyle(fontSize: 28),
            ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: App(),
      ),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        ListPage(widgetList: ListRenderer.getRenderedWidgetList('list')),
        MyBottomBar.BottomBar(),
        // TopBar(),
        StatusBar(),
      ],
    );
  }
}

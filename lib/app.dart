import 'package:flutter/material.dart';

import 'package:swamp_fox/loaders/yamlLoader.dart';
import 'package:swamp_fox/widgets/bottomBar.dart' as MyBottomBar;
import 'package:swamp_fox/widgets/statusBar.dart';
import 'package:swamp_fox/widgets/topBar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    YAMLLoader.instance.loadDocuments('doctrine.yaml');
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        // ListPage(widgetList: ListRenderer.getRenderedWidgetList('list')),
        MyBottomBar.BottomBar(),
        TopBar(),
        StatusBar(),
        // DocumentModal.instance,
      ],
    );
  }
}
import 'package:flutter/material.dart';

import 'package:swamp_fox/loaders/yamlLoader.dart';
import 'package:swamp_fox/widgets/DocumentModal.dart';
import 'package:swamp_fox/widgets/deck.dart';
import 'package:swamp_fox/widgets/doctrineListView.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    YAMLLoader.instance.loadDocuments('doctrine.yaml');
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        DoctrineListView(),
        BottomBar.instance,
        TopBar.instance,
        StatusBar.instance,
        DocumentModal.instance,
      ],
    );
  }
}
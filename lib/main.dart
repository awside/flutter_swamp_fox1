import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/helper/helper.dart' as MyHelper;
import 'package:swamp_fox/topics/topicsLoader.dart' show TopicsLoader;
import 'package:swamp_fox/topics/topicBuilder.dart' show TopicsBuilder;

void main() async {
  await TopicsLoader.instance.load();
  print(TopicsBuilder.instance.topicDataList);

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
          child: Center(
            child: Text('hello world'),
          ),
        ),
      ],
    );
  }
}

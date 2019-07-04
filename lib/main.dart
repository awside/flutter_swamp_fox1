import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/firebaseStorage.dart' as MyFirebaseStorage;
import 'package:swamp_fox/doctrine.dart' as MyDoctrine;
import 'package:swamp_fox/helper.dart' as MyHelper;
import 'package:swamp_fox/modalReader.dart';
import 'package:swamp_fox/navBar.dart';
import 'package:swamp_fox/pageChanger.dart';
import 'package:swamp_fox/statusBar.dart';
import 'package:swamp_fox/titleBar.dart';
import 'package:swamp_fox/topicList.dart';

void main() async {
  MyFirebaseStorage.setup();

  await MyDoctrine.load();

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
        Container(color: Colors.white),
        TopicList(),
        PageChanger(),
        NavBar(),
        TitleBar(),
        StatusBar(),
        ModalReader(),
      ],
    );
  }
}

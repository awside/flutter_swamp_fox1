import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/doctrine.dart' as MyDoctrine;
import 'package:swamp_fox/helper/helper.dart' as MyHelper;
import 'package:swamp_fox/io/localStorage/localStorageHelper.dart'
    as MyLocalStorageHelper;
import 'package:swamp_fox/io/firebase/firebaseHelper.dart' as MyFirebaseHelper;

void main() async {
  MyFirebaseHelper.getVersionDate().then(print);
  MyFirebaseHelper.getFileList().then(print);

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

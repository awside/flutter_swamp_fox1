import 'package:flutter/material.dart';

class TopBar extends StatefulWidget {
  static double height = 34;
  static Color iconColor = Color.fromRGBO(58, 74, 81, 1);
  static Color iconColorSelected = Color.fromRGBO(255, 111, 61, 1);
  static Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(height: MediaQuery.of(context).padding.top),
            Container(
              height: TopBar.height,
              child: TitleBar(),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        'Title',
        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, letterSpacing: 1.5 ,color: TopBar.iconColor),
      ),
    );
  }
}

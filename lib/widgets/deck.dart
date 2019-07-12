import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  static final StatusBar instance = StatusBar._privateConstructor();
  StatusBar._privateConstructor();

  final Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: Colors.white,
    );
  }
}

class TopBar extends StatefulWidget {
  static final TopBar instance = TopBar._privateConstructor();
  TopBar._privateConstructor();
  static final _TopBarState state = _TopBarState();

  final double height = 34;
  final Color iconColor = Color.fromRGBO(58, 74, 81, 1);
  final Color iconColorSelected = Color.fromRGBO(255, 111, 61, 1);
  final Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  _TopBarState createState() => state;
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
              height: widget.height,
              child: Text(
                'Title',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: widget.iconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

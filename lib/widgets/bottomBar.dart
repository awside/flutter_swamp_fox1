import 'package:flutter/material.dart';
import 'package:swamp_fox/widgets/buttonBar.dart' as MyButtonBar;

class BottomBar extends StatefulWidget {
  static Color backgroundColor = Color.fromRGBO(216, 225, 211, 1);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: IntrinsicHeight(
        child: Container(
          color: BottomBar.backgroundColor,
          child: Column(
            children: <Widget>[
              MyButtonBar.ButtonBar(),
              Container(height: MediaQuery.of(context).padding.bottom)
            ],
          ),
        ),
      ),
    );
  }
}

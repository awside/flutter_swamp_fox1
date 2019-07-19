import 'package:flutter/material.dart';
import 'package:swamp_fox/widgets/deck/nav_bar.dart';
import 'package:swamp_fox/widgets/deck/status_bar.dart';
import 'package:swamp_fox/widgets/deck/roll_sheet.dart';
import 'package:swamp_fox/widgets/deck/tint.dart';
import 'package:swamp_fox/widgets/deck/title_bar.dart';

class Deck extends StatelessWidget {
  static final Deck instance = Deck._privateConstructor();
  Deck._privateConstructor();

  final navBar = NavBar();
  final titleBar = TitleBar();
  final statusBar = StatusBar();
  final tint = Tint();
  final rollSheet = RollSheet();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Align(
          alignment: Alignment(0, -0.5),
          child: RaisedButton(
            onPressed: () {
              rollSheet.bloc.open();
            },
          ),
        ),
        navBar,
        titleBar,
        statusBar,
        tint,
        rollSheet,
      ],
    );
    
  }
}




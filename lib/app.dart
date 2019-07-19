import 'package:flutter/material.dart';
import 'package:swamp_fox/helper/helper.dart';
import 'package:swamp_fox/widgets/deck/roll_sheet.dart';
import 'package:swamp_fox/widgets/deck/tint.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenSize.instance.setSizes(context);
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.white,
        ),
        Align(
          alignment: Alignment(0, -0.5),
          child: RaisedButton(
            onPressed: () {
              RollSheet.instance.event(
                RollSheetContent(
                  Container(
                    height: 300,
                    width: 300,
                    color: Colors.blue,
                  ),
                ),
              );
              Tint.instance.event(TintOn());
              RollSheet.instance.event(RollSheetOpen());
            },
          ),
        ),
        Tint.instance,
        RollSheet.instance,
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:swamp_fox/bloc/bloc.dart';
import 'package:swamp_fox/helper/screen_ruler.dart';

class TitleBarData {
  String title = 'Title';
  double height = 34;
  Color backgroundColor = Colors.white;
  Color iconColor = Color.fromRGBO(58, 74, 81, 1);
  Color iconColorSelected = Color.fromRGBO(255, 111, 61, 1);
}

class TitleBarBloc extends Bloc<TitleBarData> {
  var eventStateObj = TitleBarData();
}

class TitleBar extends StatelessWidget {
  final bloc = TitleBarBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TitleBarData>(
        stream: bloc.stream,
        initialData: bloc.eventStateObj,
        builder: (context, snapshot) {
          return IntrinsicHeight(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Container(height: ScreenSize.instance.paddingTop),
                  Container(
                    height: snapshot.data.height,
                    child: Text(
                      snapshot.data.title,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                        color: snapshot.data.iconColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

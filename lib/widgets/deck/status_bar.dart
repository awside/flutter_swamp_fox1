import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/bloc/bloc.dart';
import 'package:swamp_fox/helper/screen_ruler.dart';

class StatusBarData {
  Color backgroundColor = Colors.white;
}

class StatusBarBloc extends Bloc<StatusBarData> {
  var eventStateObj = StatusBarData();

  statusBarLight() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light
        .copyWith(statusBarIconBrightness: Brightness.light));
  }

  statusBarDark() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarIconBrightness: Brightness.dark));
  }
}

class StatusBar extends StatelessWidget {
  final bloc = StatusBarBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StatusBarData>(
        stream: bloc.stream,
        initialData: bloc.eventStateObj,
        builder: (context, snapshot) {
          return Container(
            height: ScreenSize.instance.paddingTop,
            color: snapshot.data.backgroundColor,
          );
        });
  }
}

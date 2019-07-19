import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swamp_fox/bloc/bloc.dart';

class TintData {
  bool offStage = true;
  Duration duration = Duration(milliseconds: 0);
  double opacity = 0;
}

class TintBloc extends Bloc<TintData> {
  var eventStateObj = TintData();

  turnOn({int speed = 300}) {
    eventStateObj.offStage = false;
    eventStateObj.duration = Duration(milliseconds: 300);
    eventStateObj.opacity = 0.5;
    sink();
  }

  turnOff({int speed = 300}) {
    eventStateObj.duration = Duration(milliseconds: speed);
    eventStateObj.opacity = 0;
    Timer(Duration(milliseconds: speed), this.offStage);
    sink();
  }

  offStage() {
    eventStateObj.offStage = true;
    sink();
  }
}

class Tint extends StatelessWidget {
  final bloc = TintBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TintData>(
        stream: bloc.stream,
        initialData: bloc.eventStateObj,
        builder: (context, snapshot) {
          return Offstage(
            offstage: snapshot.data.offStage,
            child: AnimatedOpacity(
              duration: snapshot.data.duration,
              opacity: snapshot.data.opacity,
              child: Container(color: Colors.black),
            ),
          );
        });
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swamp_fox/bloc/bloc.dart';

class TintEventState {
  bool offStage = true;
  Duration duration = Duration(milliseconds: 0);
  double opacity = 0;
}

class TintOn extends TintEventState {
  var offStage = false;
  var duration = Duration(milliseconds: 300);
  var opacity = 0.5;
}

class TintOff extends TintEventState {
  var offStage = false;
  var duration = Duration(milliseconds: 300);
  var opacity = 0;
}

class TintOffQuickly extends TintEventState {
  var offStage = false;
  var duration = Duration(milliseconds: 300);
  var opacity = 0;
}

class TintStageOff extends TintEventState {
  var offStage = true;
  var duration = Duration(milliseconds: 200);
  var opacity = 0;
}

class TintBloc extends Bloc<TintEventState> {
  @override
  TintEventState processEvent(TintEventState event) {
    switch (event.runtimeType) {
      case TintOffQuickly:
        Timer(Duration(milliseconds: 200), () {
          sink.add(TintStageOff());
        });
        break;
    }
    return event;
  }
}

class Tint extends StatelessWidget {
  static final Tint instance = Tint._privateConstructor();
  Tint._privateConstructor();

  final _bloc = TintBloc();

  event(TintEventState event) {
    _bloc.sink.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TintEventState>(
        stream: _bloc.stream,
        initialData: TintEventState(),
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

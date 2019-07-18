import 'package:flutter/material.dart';
import 'package:swamp_fox/bloc/bloc.dart';

class TintData {
  var offStage = true;
  var duration = Duration(milliseconds: 300);
  var opacity = 0.0;
}

enum TintEvent { open, close, closeQuickly }

class TintBloc extends Bloc<TintData, TintEvent> {
  var data = TintData();

  processEvent(event) {
    switch (event) {
      case TintEvent.open:
        data.offStage = false;
        data.duration = Duration(milliseconds: 300);
        data.opacity = 0.5;
        break;
      case TintEvent.close:
        data.offStage = true;
        data.duration = Duration(milliseconds: 300);
        data.opacity = 0.0;
        break;
      case TintEvent.closeQuickly:
        data.offStage = true;
        data.duration = Duration(milliseconds: 200);
        data.opacity = 0.0;
        break;
    }
    return data;
  }
}

class Tint extends StatelessWidget {
  static final Tint instance = Tint._privateConstructor();
  Tint._privateConstructor();

  final _tintBloc = TintBloc();

  event(TintEvent event) {
    _tintBloc.sink.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TintData>(
        stream: _tintBloc.stream,
        initialData: _tintBloc.data,
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

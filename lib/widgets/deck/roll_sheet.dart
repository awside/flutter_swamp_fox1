import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:swamp_fox/bloc/bloc.dart';
import 'package:swamp_fox/helper/screen_ruler.dart';
import 'package:swamp_fox/widgets/deck/deck.dart';

class RollSheetData {
  double location = ScreenSize.instance.screenHeight;
  Duration duration = Duration(milliseconds: 300);
  Widget content = Container();
}

class RollSheetBloc extends Bloc<RollSheetData> {
  var eventStateObj = RollSheetData();
  //
  var ignoreInput = false;

  open({int speed = 300}) {
    ignoreInput = false;
    eventStateObj.location = ScreenSize.instance.paddingTop;
    eventStateObj.duration = Duration(milliseconds: speed);
    Deck.instance.tint.bloc.turnOn(speed: speed);
    sink();
  }

  close({int speed = 300}) {
    ignoreInput = true;
    eventStateObj.location = ScreenSize.instance.screenHeight;
    eventStateObj.duration = Duration(milliseconds: speed);
    Deck.instance.tint.bloc.turnOff(speed: speed);
    sink();
  }

  move(double y) {
    if (ignoreInput) return;
    if (y > 15) {
      close(speed: 200);
      return;
    }
    eventStateObj.location += y;
    eventStateObj.duration = Duration(milliseconds: 0);
    eventStateObj.location =
        max(eventStateObj.location, ScreenSize.instance.paddingTop);
    sink();
  }

  set content(Widget content) {
    eventStateObj.content = content;
    sink();
  }

  // PullBar

  onVerticalDragStart(DragStartDetails value) {}

  onVerticalDragUpdate(DragUpdateDetails value) {
    move(value.delta.dy);
  }

  onVerticalDragEnd() {
    if (eventStateObj.location > ScreenSize.instance.paddingTop + 50) {
      close();
    } else {
      open(speed: 100);
    }
  }
}

class RollSheet extends StatelessWidget {
  final bloc = RollSheetBloc();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RollSheetData>(
        stream: bloc.stream,
        initialData: bloc.eventStateObj,
        builder: (context, snapshot) {
          return AnimatedPositioned(
            top: snapshot.data.location,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
            duration: snapshot.data.duration,
            curve: Curves.easeInOut,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    PullBar(
                      onVerticalDragStart: bloc.onVerticalDragStart,
                      onVerticalDragUpdate: bloc.onVerticalDragUpdate,
                      onVerticalDragEnd: bloc.onVerticalDragEnd,
                    ),
                    snapshot.data.content,
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class PullBar extends StatelessWidget {
  final Function(DragStartDetails) onVerticalDragStart;
  final Function(DragUpdateDetails) onVerticalDragUpdate;
  final Function onVerticalDragEnd;

  const PullBar(
      {this.onVerticalDragStart,
      this.onVerticalDragUpdate,
      this.onVerticalDragEnd});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails value) =>
          onVerticalDragStart?.call(value),
      onVerticalDragUpdate: (DragUpdateDetails value) =>
          onVerticalDragUpdate?.call(value),
      onVerticalDragEnd: (f) => onVerticalDragEnd?.call(),
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxHeight: 5, maxWidth: 60),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ),
      ),
    );
  }
}

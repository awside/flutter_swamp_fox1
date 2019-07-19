import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:swamp_fox/bloc/bloc.dart';
import 'package:swamp_fox/helper/helper.dart';

import 'pullbar.dart';

class RollSheetEventState {
  double location = ScreenSize.instance.screenHeight;
  Duration duration = Duration(milliseconds: 0);
  Widget content = Container();
}

class RollSheetOpen extends RollSheetEventState {
  var location = ScreenSize.instance.paddingTop;
  var duration = Duration(milliseconds: 300);
  var content;
}

class RollSheetClose extends RollSheetEventState {
  var location = ScreenSize.instance.screenHeight;
  var duration = Duration(milliseconds: 300);
}

class RollSheetContent extends RollSheetEventState {
  RollSheetContent(Widget content) {
    this.content = content;
    location = null;
    duration = null;
  }
}

class RollSheetBloc extends Bloc<RollSheetEventState> {
  var eventState = RollSheetEventState();

  @override
  RollSheetEventState processEvent(RollSheetEventState event) {
    eventState.location ??= event.location;
    eventState.duration ??= event.duration;
    eventState.content ??= event.content;
    return eventState;
  }
}

class RollSheet extends StatelessWidget {
  static final RollSheet instance = RollSheet._privateConstructor();
  RollSheet._privateConstructor();

  final _bloc = RollSheetBloc();

  event(RollSheetEventState event) {
    _bloc.sink.add(event);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<RollSheetEventState>(
        stream: _bloc.stream,
        initialData: RollSheetEventState(),
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
              child: Column(
                children: <Widget>[
                  PullBar(),
                  snapshot.data.content,
                ],
              ),
            ),
          );
        });
  }
}

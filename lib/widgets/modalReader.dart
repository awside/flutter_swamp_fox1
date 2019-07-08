import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swamp_fox/helper/emitter.dart' as Emitter;

class ModalReader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Tint(),
        ModalContent(),
      ],
    );
  }
}

class Tint extends StatefulWidget {
  @override
  _TintState createState() => _TintState();
}

class _TintState extends State<Tint> {
  bool isOffStage = true;
  Color backgroundColor = Colors.black.withAlpha(0);

  @override
  void initState() {
    super.initState();
    _emitters();
  }

  _emitters() {
    Emitter.addListener('modal tint on', (f) {
      setState(() {
        isOffStage = false;
        backgroundColor = Colors.black.withAlpha(150);
      });
    });

    Emitter.addListener('modal tint off', (f) {
      Timer(Duration(milliseconds: 200), () {
        setState(() {
          isOffStage = true;
        });
      });
      setState(() {
        backgroundColor = Colors.black.withAlpha(0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: isOffStage,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
      ),
    );
  }
}

class ModalContent extends StatefulWidget {
  @override
  _ModalContentState createState() => _ModalContentState();
}

class _ModalContentState extends State<ModalContent> {
  bool isActive = false;
  double y = 0;
  Duration duration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    _emitters();
  }

  _emitters() {
    Emitter.addListener('open modal', (value) {
      Emitter.emit('modal tint on', null);
      setState(() {
        duration = Duration(milliseconds: 200);
        isActive = true;
      });
    });
  }

  pullBarHasEngaged() {
    setState(() {
      duration = Duration(milliseconds: 0);
    });
  }

  pullBarHasReleased() {
    if (y > 50) {
      Emitter.emit('modal tint off', null);
      setState(() {
        y = 0;
        isActive = false;
        duration = Duration(milliseconds: 200);
      });
    } else {
      setState(() {
        y = 0;
        duration = Duration(milliseconds: 100);
      });
    }
  }

  moveY(double dy) {
    if (dy > 10) {
      Emitter.emit('modal tint off', null);
      setState(() {
        y = 0;
        isActive = false;
        duration = Duration(milliseconds: 200);
      });
      return;
    }
    if ((y + dy) < 0) return;
    setState(() {
      y += dy;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: isActive ? y : MediaQuery.of(context).size.height,
      duration: this.duration,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top,
            bottom: MediaQuery.of(context).padding.bottom,
            left: 8,
            right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          // mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            PullBar(this),
            Container(
              child: Text('hello world'),
            ),
          ],
        ),
      ),
    );
  }
}

class PullBar extends StatelessWidget {
  final _ModalContentState parent;

  const PullBar(this.parent);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (f) {
        parent.pullBarHasEngaged();
      },
      onVerticalDragEnd: (f) {
        parent.pullBarHasReleased();
      },
      onVerticalDragUpdate: (DragUpdateDetails value) {
        parent.moveY(value.delta.dy);
      },
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(),
            ),
            Container(
              height: 4,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}

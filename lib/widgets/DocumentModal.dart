import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swamp_fox/renderers/documentRenderer.dart';

class DocumentModal extends StatelessWidget {
  static final DocumentModal instance = DocumentModal._privateConstructor();
  DocumentModal._privateConstructor();

  turnOn() {
    Tint.instance.turnOn();
    ModalWindow.instance.turnOn();
  }

  turnOff() {
    Tint.instance.turnOff();
    ModalWindow.instance.turnOff();
  }

  turnOffQuickly() {
    Tint.instance.turnOff();
    ModalWindow.instance.turnOffQuickly();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Tint(),
      ModalWindow(),
    ]);
  }
}

class Tint extends StatefulWidget {
  static final _TintState instance = _TintState.instance;
  @override
  _TintState createState() => _TintState.instance;
}

class _TintState extends State<Tint> {
  static final _TintState instance = _TintState._privateConstructor();
  _TintState._privateConstructor();

  bool offStage = true;
  double opacity = 0;

  turnOn() {
    setState(() {
      offStage = false;
      opacity = 0.5;
    });
  }

  turnOff() {
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        offStage = true;
      });
    });
    setState(() {
      opacity = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: offStage,
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 300),
        opacity: opacity,
        child: Container(color: Colors.black),
      ),
    );
  }
}

class ModalWindow extends StatefulWidget {
  static final _ModalWindowState instance = _ModalWindowState.instance;
  @override
  _ModalWindowState createState() => _ModalWindowState.instance;
}

class _ModalWindowState extends State<ModalWindow> {
  static final _ModalWindowState instance =
      _ModalWindowState._privateConstructor();
  _ModalWindowState._privateConstructor();

  bool isActive = false;
  double yOffset = 0;
  Duration duration = Duration(milliseconds: 300);

  turnOn() {
    setState(() {
      isActive = true;
      duration = Duration(milliseconds: 300);
    });
  }

  turnOff() {
    setState(() {
      isActive = false;
      yOffset = 0;
      duration = Duration(milliseconds: 300);
    });
  }

  turnOffQuickly() {
    setState(() {
      isActive = false;
      yOffset = 0;
      duration = Duration(milliseconds: 200);
    });
  }

  setInstantMode() {
    setState(() {
      duration = Duration(milliseconds: 0);
    });
  }

  resetQuicklyToTop() {
    setState(() {
      yOffset = 0;
      duration = Duration(milliseconds: 50);
    });
  }

  shouldTurnOff() {
    if (yOffset > 50) {
      DocumentModal.instance.turnOff();
    } else {
      resetQuicklyToTop();
    }
  }

  move(double dy) {
    if (dy > 10) {
      DocumentModal.instance.turnOffQuickly();
      return;
    }
    setState(() {
      yOffset = yOffset + dy < 0 ? 0 : yOffset + dy;
    });
  }

  _getWindowPosition(BuildContext context) {
    if (!isActive) {
      return MediaQuery.of(context).size.height;
    } else {
      return MediaQuery.of(context).padding.top + yOffset;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      top: _getWindowPosition(context),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).padding.top,
      duration: duration,
      curve: Curves.easeInOut,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: Stack(
          children: <Widget>[
            DocumentRenderer.instance.document,
            PullBar(),
          ],
        ),
      ),
    );
  }
}

class PullBar extends StatefulWidget {
  @override
  _PullBarState createState() => _PullBarState();
}

class _PullBarState extends State<PullBar> {
  double topStakedDragPositionY;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (DragStartDetails value) {
        topStakedDragPositionY = value.globalPosition.dy;
        ModalWindow.instance.setInstantMode();
      },
      onVerticalDragUpdate: (DragUpdateDetails value) {
        // if (value.globalPosition.dy < MediaQuery.of(context).padding.top) {
        //   ModalWindow.instance.resetQuicklyToTop();
        //   return;
        // }
        if (value.globalPosition.dy < topStakedDragPositionY) {
          ModalWindow.instance.resetQuicklyToTop();
          return;
        }
        ModalWindow.instance.move(value.delta.dy);
      },
      onVerticalDragEnd: (f) {
        ModalWindow.instance.shouldTurnOff();
      },
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

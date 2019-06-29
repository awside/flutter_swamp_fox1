import 'package:flutter/material.dart';
import 'package:swamp_fox/emitter.dart' as Emitter;

class PageChanger extends StatefulWidget {
  @override
  _PageChangerState createState() => _PageChangerState();
}

class _PageChangerState extends State<PageChanger> {
  bool movePage = false;

  @override
  void initState() {
    emitterListeners();
    super.initState();
  }

  emitterListeners() {
    Emitter.addListener('move page', (value) {
      setState(() {
        movePage = true;
      });
    });
    Emitter.addListener('remove page', (value) {
      setState(() {
        movePage = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      left: movePage ? 0 : MediaQuery.of(context).size.width,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: Container(color: Colors.amber),
    );
  }
}

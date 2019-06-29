import 'package:flutter/material.dart';
import 'package:swamp_fox/emitter.dart' as Emitter;

final List<Widget> widgetList = [
  Container(
    child: Text('Tactics',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        )),
  ),
  Container(
    height: 5,
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    ),
  ),
  Topic(),
  Topic(),
  Topic(),
];

class TopicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView.builder(
        itemCount: widgetList.length,
        itemBuilder: (BuildContext context, int index) {
          return widgetList[index];
        },
      ),
    );
  }
}

class Topic extends StatelessWidget {
  final title = 'Topic';
  final description =
      'The topic is about the main event which will be used through this cycle. It is vital and IVO the target today.';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Emitter.emit('move page', null);
      },
      child: Container(
        margin: EdgeInsets.only(top: 2, bottom: 2),
        height: 44,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Icon(
                Icons.bookmark_border,
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(34, 34, 34, 1),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Icon(
                Icons.keyboard_arrow_right,
                color: Color.fromRGBO(34, 34, 34, 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

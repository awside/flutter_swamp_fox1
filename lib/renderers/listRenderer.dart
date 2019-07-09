import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/helper/helper.dart';
import 'package:swamp_fox/topics/topicsLoader.dart' show TopicsLoader;
import 'package:swamp_fox/widgets/modal.dart';
import 'package:typicons_flutter/typicons_flutter.dart';

class Section {
  String header;
  List<String> titleList = [];
  List<String> fileName = [];
}

class ListRenderer {
  static List<Widget> getRenderedWidgetList(String fileName) {
    List<Widget> widgetList = [];
    String data =
        TopicsLoader.instance.findTopicDataStringWithFileName(fileName);
    getJsonFromString(data)['sections'].forEach((jsonSection) {
      var section = Section();
      section.header = jsonSection['header'];
      jsonSection['items'].forEach((item) {
        section.titleList.add(item['title']);
        section.fileName.add(item['fileName']);
      });
      widgetList.add(createWidget(section));
    });
    return widgetList;
  }

  static Widget createWidget(Section section) {
    List<Widget> listItems = [];
    for (int i = 0; i < section.titleList.length; i++) {
      listItems.add(createListItem(section.titleList[i], section.fileName[i]));
    }
    return Column(
      children: <Widget>[
        createHeader(section.header),
        Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: -8,
                  color: Colors.black.withAlpha(20),
                )
              ],
            ),
            child: Column(children: listItems)),
      ],
    );
  }

  static Widget createHeader(String header) {
    return Container(
      padding: EdgeInsets.fromLTRB(32, 16, 16, 0),
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(
          header,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }

  static Widget createListItem(String data, String fileName) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        Modal.instance.turnOn();
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              data,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
            Icon(
              Typicons.document_text,
              color: Colors.blueGrey.shade400,
            ),
          ],
        ),
      ),
    );
  }
}

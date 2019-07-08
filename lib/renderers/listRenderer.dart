import 'package:flutter/material.dart';
import 'package:swamp_fox/helper/helper.dart';
import 'package:swamp_fox/topics/topicsLoader.dart' show TopicsLoader;

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
    List<Container> listItems = [];
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
                  spreadRadius: -5,
                  color: Colors.grey.shade100,
                )
              ],
            ),
            child: Column(children: listItems)),
      ],
    );
  }

  static Widget createHeader(String header) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(
          header,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.grey.shade400,
          ),
        ),
      ),
    );
  }

  static Widget createListItem(String data, String fileName) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.blueGrey.shade100,
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(
          data,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
      ),
    );
  }
}

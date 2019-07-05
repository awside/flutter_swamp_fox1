import 'package:flutter/material.dart';
import 'package:swamp_fox/helper/emitter.dart' as Emitter;

final List<Widget> widgetList = [
  Container(height: 44),
  TopicGroup(
    'FID',
    [
      TopicData('Internal Defence', 'Defend the country itself!'),
      TopicData('MDMP', 'Defend the country itself!'),
      TopicData('Auxillery', 'Defend the country itself!'),
    ],
  ),
  TopicGroup(
    'Small Unit Tactics',
    [
      TopicData('Ambush', 'Defend the country itself!'),
      TopicData('Operations Order', 'Defend the country itself!'),
      TopicData('Raid', 'Defend the country itself!'),
    ],
  ),
  Container(height: 44),
];

class TopicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.only(left: 16, right: 16),
      child: ListView.builder(
        itemCount: widgetList.length,
        itemBuilder: (BuildContext context, int index) {
          return widgetList[index];
        },
      ),
    );
  }
}

class TopicGroup extends StatelessWidget {
  final String groupTitle;
  final List<TopicData> groupTopicData;

  const TopicGroup(this.groupTitle, this.groupTopicData);

  List<Topic> buildTopics() {
    List<Topic> topicDataList = [];
    groupTopicData.forEach((topicData) {
      topicDataList.add(Topic(topicData));
    });
    return topicDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
      margin: EdgeInsets.only(left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(groupTitle,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey.shade700,
                    )),
                Container(
                  height: 0,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade600.withAlpha(150),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ],
            ),
          ),
          ...buildTopics()
        ],
      ),
    );
  }
}

class TopicData {
  final String title;
  final String description;
  TopicData(this.title, this.description);
}

class Topic extends StatelessWidget {
  final TopicData topicData;

  const Topic(this.topicData);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Emitter.emit('open modal', null);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          // border: Border.all(
          //   width: 1.0,
          //   color: Colors.grey.shade300,
          // ),
        ),
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            Container(
              height: 30,
              width: 30,
              child: Icon(
                Icons.subject,
                color: Colors.grey.shade600,
              ),
            ),
            Container(
              width: 1,
              height: 20,
              margin: EdgeInsets.only(left: 8, right: 16),
              color: Colors.grey.shade600,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    topicData.title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  // Text(
                  //   topicData.description,
                  //   style: TextStyle(
                  //     fontSize: 16,
                  //     color: Color.fromRGBO(34, 34, 34, 1),
                  //   ),
                  // ),
                ],
              ),
            ),
            // Container(
            //   child: Icon(
            //     Icons.subject,
            //     color: Color.fromRGBO(0, 0, 0, 0.5),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

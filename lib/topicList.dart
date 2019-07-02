import 'package:flutter/material.dart';
import 'package:swamp_fox/emitter.dart' as Emitter;

final List<Widget> widgetList = [
  Container(height: 44),
  TopicGroup(
    'Foriegn Internal Defense (FID)',
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
      child: ListView.separated(
        itemCount: widgetList.length,
        itemBuilder: (BuildContext context, int index) {
          return widgetList[index];
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return Container();
          }
          return Container(
            height: 0,
            margin: EdgeInsets.all(8),
            color: Colors.grey.shade300,
          );
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
      padding: EdgeInsets.all(8),
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
            child: Text(groupTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade600.withAlpha(150),
                    borderRadius: BorderRadius.circular(2),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.shade600.withAlpha(150),
                    //     blurRadius: 4,
                    //     spreadRadius: 0,
                    //     offset: Offset(5, 2),
                    //   ),
                    // ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(),
              ),
            ],
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
        ),
        margin: EdgeInsets.only(left: 8, top: 8, bottom: 8),
        child: Row(
          children: <Widget>[
            Container(
              height: 44,
              width: 30,
              child: Icon(
                Icons.subject,
                color: Color.fromRGBO(0, 0, 0, 0.5),
              ),
            ),
            Container(
              width: 1,
              height: 44,
              margin: EdgeInsets.only(left: 8, right: 16),
              color: Color.fromRGBO(0, 0, 0, 0.15),
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
                      color: Color.fromRGBO(34, 34, 34, 1),
                    ),
                  ),
                  Text(
                    topicData.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromRGBO(34, 34, 34, 1),
                    ),
                  ),
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

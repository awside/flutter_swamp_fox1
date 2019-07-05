import 'dart:async';
import 'package:flutter/material.dart';
import 'package:swamp_fox/firebaseStorage.dart' as MyFirebaseStorage;
import 'package:swamp_fox/localStorage.dart' as MyLocalStorage;

List<TopicsData> topicsDataList = [];
List<String> fileList = [];

Future load() async {
  // await MyLocalStorage.clearAllData();
  if (await _shouldUpdateDoctrine()) {
    await _updateDoctrine();
    await _loadTopics();
  } else {
    await _loadTopics();
  }
}

Future<bool> _shouldUpdateDoctrine() async {
  if (await MyLocalStorage.getData('doctrine-date') == null) return true;
  var doctrineJson =
      await MyFirebaseStorage.getJsonFromFile('doctrineInfo.json');
  var doctrineAppDate =
      DateTime.parse(await MyLocalStorage.getData('doctrine-date'));
  var doctrineFirebaseDate = DateTime.parse(doctrineJson['doctrine-date']);
  return doctrineAppDate.compareTo(doctrineFirebaseDate) != 0;
}

Future _updateDoctrine() async {
  var doctrineJson =
      await MyFirebaseStorage.getJsonFromFile('doctrineInfo.json');
  await MyLocalStorage.saveData('doctrine-date', doctrineJson['doctrine-date']);
  List<String> _fileList = [];
  await Future.forEach(doctrineJson['file-list'], (fileName) async {
    _fileList.add(fileName);
    var topicStringFile = await MyFirebaseStorage.getStringFromFile(fileName);
    await MyLocalStorage.saveData(fileName, topicStringFile);
  });
  await MyLocalStorage.saveStringListData('file-list', _fileList);
}

Future _loadTopics() async {
  var _fileList = await MyLocalStorage.getStringListData('file-list');
  await Future.forEach(_fileList, (fileName) async {
    fileList.add(fileName);
    var topicJson = await MyLocalStorage.getJsonFromData(fileName);
    topicsDataList.add(TopicsData.fromJson(topicJson));
  });
}

renderTopic(TopicsData topicsData) {
  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child: Text(topicsData.header),
        ),
        Container(
          child: _renderArticles(topicsData.articles),
        ),
      ],
    ),
  );
}

Widget _renderArticles(List<Articles> articles) {
  List<Widget> articleWidgets = articles
      .map((article) => _renderArticle(article.title, article.paragraphs))
      .toList();

  return Container(
    child: Column(
      children: articleWidgets,
    ),
  );
}

Widget _renderArticle(String title, List<String> paragraphs) {
  var paragraphWidgets = paragraphs
      .map((paragraph) => Container(
            child: Text(paragraph),
          ))
      .toList();

  return Container(
    child: Column(
      children: <Widget>[
        Container(
          child: Text(title),
        ),
        ...paragraphWidgets
      ],
    ),
  );
}

class TopicsData {
  String header;
  List<Articles> articles;

  TopicsData.fromJson(Map<String, dynamic> json) {
    header = json['header'];
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['header'] = this.header;
    if (this.articles != null) {
      data['articles'] = this.articles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Articles {
  String title;
  List<String> paragraphs;

  Articles({this.title, this.paragraphs});

  Articles.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    paragraphs = json['paragraphs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['paragraphs'] = this.paragraphs;
    return data;
  }
}

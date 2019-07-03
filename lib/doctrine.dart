import 'dart:async';
import 'package:swamp_fox/localStorage.dart' as MyLocalStorage;

List<TopicsData> topicsDataList = [];

Future load() async {
  // await _isFirstLoad();
}

Future _loadDoctrineAttempt() async {

}

Future _isFirstLoad() async {
  var value = await MyLocalStorage.getData('doctrine-date');
  if (value == null)
    await MyLocalStorage.saveData('doctrine-date', '2000-01-01');
}

Future _loadTopic(String fileName) async {
  var jsonData = await MyLocalStorage.getJson(fileName);
  topicsDataList.add(TopicsData.fromJson(jsonData));
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

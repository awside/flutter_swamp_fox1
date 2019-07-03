import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

load() {
  _loadAsset().then((value) {
    print(value);
  });
}

Future<TopicsData> _loadAsset() async {
  return TopicsData.fromJson(
      json.decode(await rootBundle.loadString('assets/fid.json')));
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

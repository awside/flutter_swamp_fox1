import 'package:flutter/material.dart';
import 'package:swamp_fox/topics/topicsLoader.dart' show TopicsLoader;
import 'package:swamp_fox/helper/helper.dart' as Helper;

class DocumentRenderer {
  static final DocumentRenderer instance =
      DocumentRenderer._privateConstructor();
  DocumentRenderer._privateConstructor();

  Widget document;
  Document _document;

  render(String fileName) {
    _document = Document.fromString(
        TopicsLoader.instance.findTopicDataStringWithFileName(fileName));
    _renderDocument();
  }

  _renderDocument() {
    return Column(
      children: <Widget>[
        HeaderItem(_document.header),
        ..._document.articleList.map((article) => ArticleItem(article)).toList()
      ],
    );
  }

  // TODO create widgets in one file?
}

class Document {
  String header;
  List<Article> articleList = [];

  Document.fromString(String data) {
    var json = Helper.getJsonFromString(data);
    header = json['header'];
    json['articles'].forEach((article) {});
  }
}

class Article {
  String title;
  List<String> paragraphList = [];

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    json['paragraphs'].forEach((para) {
      paragraphList.add(para);
    });
  }
}

class HeaderItem extends StatelessWidget {
  final String header;

  const HeaderItem(this.header);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(
          header,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class ArticleItem extends StatelessWidget {
  final Article article;
  List<Widget> widgetList = [];

  ArticleItem(this.article) {
    widgetList.add(buildTitle(article.title));
    article.paragraphList.forEach((paragraph) {
      widgetList.add(buildParagraph(paragraph));
    });
  }

  Widget buildTitle(String title) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }

  Widget buildParagraph(String paragraph) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Align(
        alignment: Alignment(-1, 0),
        child: Text(
          paragraph,
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widgetList,
      ),
    );
  }
}

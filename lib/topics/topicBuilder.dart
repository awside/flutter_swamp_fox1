import 'dart:convert';

class TopicsBuilder {
  static final TopicsBuilder instance = TopicsBuilder._privateConstructor();
  TopicsBuilder._privateConstructor();

  List<TopicData> topicDataList = [];

  build(List<String> topicDataStringList) {
    topicDataList = topicDataStringList
        .map((topicDataString) => TopicData.fromString(topicDataString))
        .toList();
  }
}

class TopicData {
  String header;
  List<Articles> articles;

  TopicData.fromString(String data) {
    Map<String, dynamic> json = jsonDecode(data);
    header = json['header'];
    if (json['articles'] != null) {
      articles = new List<Articles>();
      json['articles'].forEach((v) {
        articles.add(new Articles.fromJson(v));
      });
    }
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
}

// renderTopic(TopicsData topicsData) {
//   return Container(
//     child: Column(
//       children: <Widget>[
//         Container(
//           child: Text(topicsData.header),
//         ),
//         Container(
//           child: _renderArticles(topicsData.articles),
//         ),
//       ],
//     ),
//   );
// }

// Widget _renderArticles(List<Articles> articles) {
//   List<Widget> articleWidgets = articles
//       .map((article) => _renderArticle(article.title, article.paragraphs))
//       .toList();

//   return Container(
//     child: Column(
//       children: articleWidgets,
//     ),
//   );
// }

// Widget _renderArticle(String title, List<String> paragraphs) {
//   var paragraphWidgets = paragraphs
//       .map((paragraph) => Container(
//             child: Text(paragraph),
//           ))
//       .toList();

//   return Container(
//     child: Column(
//       children: <Widget>[
//         Container(
//           child: Text(title),
//         ),
//         ...paragraphWidgets
//       ],
//     ),
//   );
// }

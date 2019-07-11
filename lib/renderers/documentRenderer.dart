// import 'package:flutter/material.dart';
// import 'package:swamp_fox/topics/topicsLoader.dart' show TopicsLoader;
// import 'package:swamp_fox/helper/helper.dart' as Helper;

// class DocumentRenderer {
//   static final DocumentRenderer instance =
//       DocumentRenderer._privateConstructor();
//   DocumentRenderer._privateConstructor();

//   Widget document = Container();
//   List<Widget> _listViewItems = [];
//   Document _document;

//   render(String fileName) {
//     _document = Document.fromString(
//         TopicsLoader.instance.findTopicDataStringWithFileName(fileName));
//     _renderDocument();
//   }

//   _renderDocument() {
//     _listViewItems = [HeaderItem(_document.header)];
//     _document.articleList.forEach((article) {
//       _listViewItems.add(ArticleItem(article));
//       _listViewItems.add(_buildLineSpacer());
//     });
//     _listViewItems.removeLast();
//     document = null;
//     document = Container(
//       color: Colors.white,
//       child: ListView.builder(
//         itemCount: _listViewItems.length,
//         itemBuilder: (BuildContext context, int index) {
//           return _listViewItems[index];
//         },
//       ),
//     );
//   }

//   Widget _buildLineSpacer() {
//     return Container(
//       height: 20,
//       child: Center(
//           child: Container(
//         height: 1,
//         width: 200,
//         color: Colors.black,
//       )),
//     );
//   }
// }

// class Document {
//   String header;
//   List<Article> articleList = [];

//   Document.fromString(String data) {
//     var json = Helper.getJsonFromString(data);
//     header = json['header'];
//     json['articles'].forEach((article) {
//       articleList.add(Article.fromJson(article));
//     });
//   }
// }

// class Article {
//   String title;
//   List<String> paragraphList = [];

//   Article.fromJson(Map<String, dynamic> json) {
//     title = json['title'];
//     json['paragraphs'].forEach((para) {
//       paragraphList.add(para);
//     });
//   }
// }

// class HeaderItem extends StatelessWidget {
//   final String header;

//   const HeaderItem(this.header);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Align(
//         alignment: Alignment(0, 0),
//         child: Text(
//           header,
//           style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }
// }

// class ArticleItem extends StatelessWidget {
//   final Article article;
//   final List<Widget> widgetList = [];

//   ArticleItem(this.article) {
//     widgetList.add(buildTitle(article.title));
//     article.paragraphList.forEach((paragraph) {
//       widgetList.add(buildParagraph(paragraph));
//     });
//   }

//   Widget buildTitle(String title) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Align(
//         alignment: Alignment(-1, 0),
//         child: Text(
//           title,
//           style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//         ),
//       ),
//     );
//   }

//   Widget buildParagraph(String paragraph) {
//     return Container(
//       padding: EdgeInsets.all(8),
//       child: Align(
//         alignment: Alignment(-1, 0),
//         child: Text(
//           paragraph,
//           style: TextStyle(fontSize: 16),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: widgetList,
//       ),
//     );
//   }
// }

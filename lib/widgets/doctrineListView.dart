import 'package:flutter/material.dart';
import 'package:swamp_fox/loaders/yamlLoader.dart';
import 'package:swamp_fox/widgets/DocumentModal.dart';
import 'package:swamp_fox/widgets/topBar.dart';

class DoctrineListView extends StatefulWidget {
  @override
  _DoctrineListViewState createState() => _DoctrineListViewState();
}

class _DoctrineListViewState extends State<DoctrineListView> {
  final doctrineFileName = 'doctrine.yaml';
  List<Widget> doctrineList = [];

  @override
  void initState() {
    super.initState();
    buildDoctrineWidgetList().then((list) {
      setState(() {
        doctrineList = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctrineList.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) return Container(height: TopBar.height);
        return doctrineList[index - 1];
      },
    );
  }

  Future<List<Widget>> buildDoctrineWidgetList() async {
    List<Widget> list = [];
    var doctrine = await YAMLLoader.instance.loadDocuments(doctrineFileName);
    doctrine.forEach((doc) {
      list.add(buildHeader(doc['document']));
      doc['topics'].forEach((topic) {
        list.add(buildTopic(topic));
      });
    });
    return list;
  }

  Widget buildHeader(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildTopic(dynamic topic) {
    return GestureDetector(
      onTap: () {
        DocumentModal.instance.updateContent(DoctrineReader(topic['sections']));
        DocumentModal.instance.turnOn();
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          topic['name'],
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

class DoctrineReader extends StatelessWidget {
  final List<Widget> doctrineList = [];

  DoctrineReader(dynamic sections) {
    sections.forEach((section) {
      doctrineList.add(buildTitle(section['title']));
      section['paragraphs'].forEach((paragraph) {
        doctrineList.add(buildTitle(paragraph));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: doctrineList.length,
      itemBuilder: (BuildContext context, int index) {
        return doctrineList[index];
      },
    );
  }

  Widget buildTitle(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget buildParagraph(String title) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
      padding: EdgeInsets.all(8),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}

import 'dart:async';

import 'package:swamp_fox/fileCache/file_cache.dart';
import 'package:swamp_fox/helper/helper.dart';

class Doctrine {
  StreamController<List<Document>> _streamController = StreamController();
  Stream<List<Document>> get stream => _streamController.stream;
  StreamSink<List<Document>> get _sink => _streamController.sink;
  List<Document> _documents = [];
  List<dynamic> _yamlDocList = [];

  Doctrine() {
    _load();
  }

  close() {
    _streamController.close();
  }

  Future<Null> _load() async {
    var fileCache = FileCache('doctrine.yaml');
    fileCache.stream.listen((data) {
      _yamlDocList = getYamlDocumentsFromString(data as String);
      _createDocuments();
      _sink.add(_documents);
    });
  }

  _createDocuments() {
    for (var yamlDoc in _yamlDocList) {
      _documents.add(Document(yamlDoc));
    }
  }
}

class Document {
  String name;
  List<Topic> topics = [];

  Document(dynamic data) {
    name = data['document'];
    for (var topic in data['topics']) {
      topics.add(Topic(topic));
    }
  }
}

class Topic {
  String name;
  List<Section> sections = [];

  Topic(dynamic data) {
    name = data['name'];
    for (var section in data['sections']) {
      sections.add(Section(section));
    }
  }
}

class Section {
  String title;
  List<String> paragraphs = [];

  Section(dynamic data) {
    title = data['title'];
    for (var paragraph in data['paragraphs']) {
      paragraphs.add(paragraph);
    }
  }
}

import 'package:swamp_fox/io/firebase.dart';
import 'package:yaml/yaml.dart';

class YAMLLoader {
  static final YAMLLoader instance = YAMLLoader._privateConstructor();
  YAMLLoader._privateConstructor();

  Future<List<dynamic>> loadDocuments(String fileName) async {
    var file = await FBStorage.instance.getStringFromFile(fileName);
    var yamlDocList = loadYamlDocuments(file);
    var docList = <dynamic>[];
    yamlDocList.forEach((yamlDoc) {
      docList.add(yamlDoc.contents.value);
    });
    return docList;
  }
}

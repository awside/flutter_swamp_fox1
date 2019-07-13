import 'package:swamp_fox/firebase/fb_storage.dart';
import 'package:yaml/yaml.dart';

class YAMLLoader {
  static final YAMLLoader instance = YAMLLoader._privateConstructor();
  YAMLLoader._privateConstructor();

  Future<List<dynamic>> loadDocuments(String fileName) async {
    var file = await FBStorage.instance.getStringFromFile(fileName);
    var yamlDocList = loadYamlDocuments(file);
    var docList = <dynamic>[];
    for (var yamlDoc in yamlDocList) {
      docList.add(yamlDoc.contents.value);
    }
    return docList;
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class FBStorage {
  static final FBStorage instance = FBStorage._privateConstructor();
  FBStorage._privateConstructor();

  Future<String> getStringFromFile(String fileName) async {
    var url =
        await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
    var response = await http.get(url);
    return response.body;
  }

  Future<StorageMetadata> getMetadataFromFile(String fileName) async {
    return await FirebaseStorage.instance.ref().child(fileName).getMetadata();
  }

  Future<int> getTimeUpdated(String fileName) async {
    var metaData = await getMetadataFromFile(fileName);
    return metaData.updatedTimeMillis;
  }
}

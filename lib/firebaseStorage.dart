import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

FirebaseStorage storage;

setup() {
  storage = FirebaseStorage(storageBucket: 'gs://testsite1-36e94.appspot.com/');
}

Future<String> getStringFromFile(String fileName) async {
  var url = await storage.ref().child(fileName).getDownloadURL();
  var response = await http.get(url);
  return response.body;
}

Future getJsonFromFile(String fileName) async {
  var stringData = await getStringFromFile(fileName);
  return json.decode(stringData);
}

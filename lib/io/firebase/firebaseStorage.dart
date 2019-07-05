import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;


Future<String> getStringFromFile(String fileName) async {
  var url = await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
  var response = await http.get(url);
  return response.body;
}

Future getJsonFromFile(String fileName) async {
  var stringData = await getStringFromFile(fileName);
  return json.decode(stringData);
}

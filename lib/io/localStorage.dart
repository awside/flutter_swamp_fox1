import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> _localPath() async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> _localFile(String fileName) async {
  final path = await _localPath();
  return File('$path/$fileName');
}

Future<File> writeFile(String text, String fileName) async {
  final file = await _localFile(fileName);
  return file.writeAsString(text);
}

Future<String> readFile(String fileName) async {
  try {
    final file = await _localFile(fileName);
    final exists = await file.exists();
    if (!exists) return null;
    return await file.readAsString();
  } catch (e) {
    return null;
  }
}

Future<bool> deleteFile(String fileName) async {
  final file = await _localFile(fileName);
  final exists = await file.exists();
  if (!exists) return false;
  file.deleteSync(recursive: true);
  return true;
}

Future getJsonFromFile(String fileName) async {
  var stringData = await readFile(fileName);
  return json.decode(stringData);
}

Future<SharedPreferences> _getPrefs() async {
  SharedPreferences prefs;
  try {
    prefs = await SharedPreferences.getInstance();
  } catch (e) {
    print(e);
  }
  return prefs;
}

Future saveData(String key, String data) async {
  var prefs = await _getPrefs();
  await prefs?.setString(key, data);
}

Future<String> getData(String key) async {
  var prefs = await _getPrefs();
  return prefs?.getString(key);
}

Future getJsonFromData(String key) async {
  var prefs = await _getPrefs();
  return json.decode(prefs?.getString(key));
}

Future saveStringListData(String key, List<String> data) async {
  var prefs = await _getPrefs();
  await prefs?.setStringList(key, data);
}

Future<List<String>> getStringListData(String key) async {
  var prefs = await _getPrefs();
  return prefs?.getStringList(key);
}

Future removeData(String key) async {
  var prefs = await _getPrefs();
  await prefs?.remove(key);
}

Future clearAllData() async {
  var prefs = await _getPrefs();
  prefs.clear();
}

import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._privateConstructor();
  LocalStorage._privateConstructor();

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
}

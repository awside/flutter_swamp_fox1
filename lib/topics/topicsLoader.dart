import 'dart:async';
import 'dart:math';
import 'package:swamp_fox/io/localStorage/localStorage.dart' as MyLocalStorage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swamp_fox/io/firebase/firestore.dart' as MyFirestore;
import 'package:swamp_fox/io/firebase/storage.dart' as MyFirebaseStorage;
import 'package:swamp_fox/topics/topicBuilder.dart' show TopicsBuilder;

class TopicsLoader {
  static final TopicsLoader instance = TopicsLoader._privateConstructor();
  TopicsLoader._privateConstructor();

  List<String> topicDataStringList = [];
  List<String> topicFileNameList = [];

  String findTopicDataStringWithFileName(String fileName) {
    for (int i = 0; i < topicFileNameList.length; i++) {
      if (topicFileNameList[i] == fileName) return topicDataStringList[i];
    }
    return null;
  }

  Future load() async {
    await loadFromLocal();
    await shouldLoadFromFirebase();
  }

  Future loadFromLocal() async {
    topicFileNameList = await LocalStorage.instance.getFileNameList() ?? [];
    topicDataStringList =
        await LocalStorage.instance.getTopicDataStringList(topicFileNameList) ??
            [];
    TopicsBuilder.instance.build(topicDataStringList);
  }

  Future saveToLocal() async {
    await LocalStorage.instance.saveFileNameList(topicFileNameList);
    await LocalStorage.instance
        .saveTopicDataStringList(topicFileNameList, topicDataStringList);
  }

  Future shouldLoadFromFirebase() async {
    if ((await LocalStorage.instance.getFileNameList()) == null ||
        (await doesLocalVersionDateNeedUpdate())) {
      await loadFromFirebase();
    }
  }

  Future loadFromFirebase() async {
    await updateLocalVersionDate();
    topicFileNameList = await Firestore.instance.getFileList();
    topicDataStringList = await FirebaseStorage.instance
        .getTopicDataStringList(topicFileNameList);
    saveToLocal();
    TopicsBuilder.instance.build(topicDataStringList);
  }

  Future<bool> doesLocalVersionDateNeedUpdate() async {
    DateTime localDate = await LocalStorage.instance.getVersionDate();
    DateTime firestoreDate = await Firestore.instance.getVersionDate();
    return localDate.compareTo(firestoreDate) != 0;
  }

  Future updateLocalVersionDate() async {
    await LocalStorage.instance
        .setVersionDate(await Firestore.instance.getVersionDate());
  }
}

class LocalStorage {
  static final LocalStorage instance = LocalStorage._privateConstructor();
  LocalStorage._privateConstructor();

  final String _versionDateKey = 'version-date';
  final String _fileNameListKey = 'file-list';

  Future<void> clearAll() async {
    await MyLocalStorage.clearAllData();
  }

  // VERSION DATE //////////////

  Future<DateTime> getVersionDate() async {
    String dateTimeString = await MyLocalStorage.getData(_versionDateKey);
    return dateTimeString != null
        ? DateTime.parse(dateTimeString)
        : DateTime(0);
  }

  Future<void> setVersionDateZero() async {
    await MyLocalStorage.saveData(
        _versionDateKey, DateTime.fromMillisecondsSinceEpoch(0).toString());
  }

  Future<void> setVersionDate(DateTime dateTime) async {
    await MyLocalStorage.saveData(_versionDateKey, dateTime.toString());
  }

  // File Name List //////////////

  Future<List<String>> getFileNameList() async {
    return await MyLocalStorage.getStringListData(_fileNameListKey);
  }

  Future<void> saveFileNameList(List<String> fileList) async {
    await MyLocalStorage.saveStringListData(_fileNameListKey, fileList);
  }

  // Topic Data //////////////

  Future<String> getTopicDataString(String fileName) async {
    return await MyLocalStorage.getData('topic-$fileName');
  }

  Future<void> saveTopicDataString(
      String fileName, String topicDataString) async {
    await MyLocalStorage.saveData('topic-$fileName', topicDataString);
  }

  // Topic Data List //////////////

  Future<List<String>> getTopicDataStringList(
      List<String> topicFileNameList) async {
    List<String> list = [];
    await Future.forEach(topicFileNameList, (fileName) async {
      var data = await getTopicDataString(fileName);
      if (data != null) list.add(data);
    });
    return list.length > 0 ? list : null;
  }

  Future<void> saveTopicDataStringList(
      List<String> topicFileNameList, List<String> topicDataStringList) async {
    int minLength = min(topicFileNameList.length, topicDataStringList.length);
    for (int i = 0; i < minLength; i++) {
      await LocalStorage.instance
          .saveTopicDataString(topicFileNameList[i], topicDataStringList[i]);
    }
  }
}

class Firestore {
  static final Firestore instance = Firestore._privateConstructor();
  Firestore._privateConstructor();

  final String _versionDateKey = 'version-date';
  final String _fileListKey = 'file-list';

  Future<DateTime> getVersionDate() async {
    Timestamp ts =
        await MyFirestore.getField('doctrine', 'info', _versionDateKey);
    return ts.toDate();
  }

  Future<List<String>> getFileList() async {
    var list = await MyFirestore.getField('doctrine', 'info', _fileListKey);
    return List<String>.from(list);
  }
}

class FirebaseStorage {
  static final FirebaseStorage instance = FirebaseStorage._privateConstructor();
  FirebaseStorage._privateConstructor();

  Future getTopicDataString(String fileName) async {
    return await MyFirebaseStorage.getStringFromFile('$fileName.json');
  }

  Future<List<String>> getTopicDataStringList(
      List<String> topicFileNameList) async {
    List<String> list = [];
    await Future.forEach(topicFileNameList, (fileName) async {
      var data = await getTopicDataString(fileName);
      if (data != null) list.add(data);
    });
    return list.length > 0 ? list : null;
  }
}

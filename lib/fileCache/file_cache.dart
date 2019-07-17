import 'dart:async';

import 'package:swamp_fox/firebase/fb_firestore.dart';
import 'package:swamp_fox/firebase/fb_storage.dart';
import 'package:swamp_fox/localStorage/local_storage.dart';
import 'package:swamp_fox/user/user_info.dart';

class FileCache {
  StreamController _streamController = StreamController();
  Stream get stream => _streamController.stream;
  StreamSink get _sink => _streamController.sink;
  final String fileName;

  FileCache(this.fileName) {
    _load();
  }

  close() {
    _streamController.close();
  }

  Future<Null> _load() async {
    var didLoadLocal = await _loadFromLocal();
    if (!didLoadLocal || await _needsUpdateFromServer()) {
      var data = await _loadFromServer();
      await _updateLocal(data);
      return;
    }
  }

  Future<bool> _loadFromLocal() async {
    var data = await LocalStorage.instance.readFile(fileName);
    if (data != null) {
      _sink.add(data);
      return true;
    } else {
      return false;
    }
  }

  Future<String> _loadFromServer() async {
    var data = await FBStorage.instance.getStringFromFile(fileName);
    _sink.add(data);
    return data;
  }

  Future<Null> _updateLocal(String data) async {
    await LocalStorage.instance.writeFile(data, fileName);
    await _setCurrentTimeMillis();
  }

  Future<bool> _needsUpdateFromServer() async {
    return await _getCurrentTimeMillis() < await _getFBUpdatedTimeMillis();
  }

  Future<Null> _setCurrentTimeMillis() async {
    var newTime = await _getFBUpdatedTimeMillis();
    await FBFirestore.instance.setData('metadata', UserInfo.instance.userID,
        {'doctrine-last-update': newTime});
  }

  Future<int> _getCurrentTimeMillis() async {
    int time = await FBFirestore.instance
        .getData('metadata', UserInfo.instance.userID, 'doctrine-last-update');
    return time ?? 0;
  }

  Future<int> _getFBUpdatedTimeMillis() async {
    var ts = await FBStorage.instance.getMetadataFromFile(fileName);
    return ts.updatedTimeMillis;
  }
}

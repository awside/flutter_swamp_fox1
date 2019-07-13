import 'package:shared_preferences/shared_preferences.dart';

class LocalKeyData {
  static final LocalKeyData instance = LocalKeyData._privateConstructor();
  LocalKeyData._privateConstructor() {
    _getPrefs().then((prefsInstance) {
      _prefs = prefsInstance;
    });
  }

  SharedPreferences _prefs;

  Future<SharedPreferences> _getPrefs() async {
    if (_prefs != null) return _prefs;
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      print(e);
      return null;
    }
    return _prefs;
  }

  Future saveData(String key, String data) async {
    var prefs = await _getPrefs();
    await prefs?.setString(key, data);
  }

  Future<String> getData(String key) async {
    var prefs = await _getPrefs();
    return prefs?.getString(key);
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
}
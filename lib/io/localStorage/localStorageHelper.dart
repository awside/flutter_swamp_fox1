import 'package:swamp_fox/io/localStorage/localStorage.dart' as MyLocalStorage;

final String _versionDateKey = 'version-date';
final String _fileListKey = 'file-list';

Future<DateTime> getDateTime() async {
  String dateTimeString = await MyLocalStorage.getData(_versionDateKey);
  return dateTimeString != null ? DateTime.parse(dateTimeString) : DateTime(0);
}

setDateTime(DateTime dateTime) async {
  await MyLocalStorage.saveData(_versionDateKey, dateTime.toString());
}

Future<List<String>> getFileList() async {
  List<String> fileList = await MyLocalStorage.getStringListData(_fileListKey);
  return fileList == null ? fileList : [];
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swamp_fox/io/firebase/firestore.dart' as MyFirestore;

final String _versionDateKey = 'version-date';
final String _fileListKey = 'file-list';

Future<DateTime> getVersionDate() async {
  Timestamp ts = await MyFirestore.getField('info', 'info', _versionDateKey);
  return ts.toDate();
}

Future<List<dynamic>> getFileList() async {
  return await MyFirestore.getField('info', 'info', _fileListKey);
}

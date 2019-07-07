// import 'dart:async';
// import 'package:swamp_fox/io/localStorage/localStorageHelper.dart' as MyLocalStorage;
// import 'package:swamp_fox/io/firebase/firebaseHelper.dart' as MyFirebase;

// List<TopicsData> topicsDataList = [];
// List<String> fileList = [];

// Future load() async {
//   // await MyLocalStorage.clearAllData();
//   if (await _shouldUpdateDoctrine()) {
//     await _updateDoctrine();
//     await _loadTopics();
//   } else {
//     await _loadTopics();
//   }
// }

// Future<bool> _shouldUpdateDoctrine() async {
//   String localStringVersionDateNum = await MyLocalStorage.getData('version-date');
//   if (localStringVersionDateNum == null) return true;
  
//   Timestamp localVersionTimestamp = Timestamp.fromMillisecondsSinceEpoch(int.parse(localStringVersionDateNum));
//   Timestamp firestoreVersionTimestamp = await MyFirestore.getField('info', 'info', 'version-date');
  
//   return localVersionTimestamp.compareTo(firestoreVersionTimestamp) != 0;
// }

// Future _updateDoctrine() async {
//   var doctrineJson =
//       await MyFirebaseStorage.getJsonFromFile('doctrineInfo.json');
//   await MyLocalStorage.saveData('doctrine-date', doctrineJson['doctrine-date']);
//   List<String> _fileList = [];
//   await Future.forEach(doctrineJson['file-list'], (fileName) async {
//     _fileList.add(fileName);
//     var topicStringFile = await MyFirebaseStorage.getStringFromFile(fileName);
//     await MyLocalStorage.saveData(fileName, topicStringFile);
//   });
//   await MyLocalStorage.saveStringListData('file-list', _fileList);
// }

// Future _loadTopics() async {
//   var _fileList = await MyLocalStorage.getStringListData('file-list');
//   await Future.forEach(_fileList, (fileName) async {
//     fileList.add(fileName);

//     var topicJson = await MyLocalStorage.getJsonFromData(fileName);
//     topicsDataList.add(TopicsData.fromJson(topicJson));
//   });
// }

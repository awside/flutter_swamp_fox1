import 'package:cloud_firestore/cloud_firestore.dart';

class FBFirestore {
  static final FBFirestore instance = FBFirestore._privateConstructor();
  FBFirestore._privateConstructor();

  Future<dynamic> getData(
      String collection, String document, String field) async {
    var value = await Firestore.instance
        .collection(collection)
        .document(document)
        .get();
    return value[field];
  }

  Future<Null> setData(
      String collection, String document, Map<String, dynamic> data) async {
        await Firestore.instance.collection(collection)
        .document(document).setData(data, merge: true);
      }
}

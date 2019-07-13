import 'package:cloud_firestore/cloud_firestore.dart';

class FBFirestore {
  static final FBFirestore instance = FBFirestore._privateConstructor();
  FBFirestore._privateConstructor();

  Future<dynamic> getField(
      String collection, String document, String field) async {
    var value = await Firestore.instance
        .collection(collection)
        .document(document)
        .get();
    return value[field];
  }
}

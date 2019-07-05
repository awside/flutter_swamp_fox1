import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> getField(String collection, String document, String field) async {
  var value = await Firestore.instance.collection(collection).document(document).get();
  return value[field];
}



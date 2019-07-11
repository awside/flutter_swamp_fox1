import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class FBAuth {
  static final FBAuth instance = FBAuth._privateConstructor();
  FBAuth._privateConstructor();

  onAuthStateChanged() {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {});
  }

  Future<FirebaseUser> getCurrentUser() async {
    return await FirebaseAuth.instance.currentUser();
  }

  Future signUp(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          print('email already in use');
          break;
        case 'ERROR_INVALID_EMAIL':
          print('invalid email');
          break;
        case 'ERROR_WEAK_PASSWORD':
          print('weak password');
          break;
        default:
          print("something went wrong");
          print(e.code);
          break;
      }
    }
  }

  Future signIn(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on PlatformException catch (e) {
      switch (e.code) {
        case 'ERROR_USER_NOT_FOUND':
          print('user not found');
          break;
        case 'ERROR_INVALID_EMAIL':
          print('invalid email');
          break;
        case 'ERROR_WRONG_PASSWORD':
          print('wrong password');
          break;
        default:
          print("something went wrong");
          print(e.code);
          break;
      }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

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

class FBStorage {
  static final FBStorage instance = FBStorage._privateConstructor();
  FBStorage._privateConstructor();

  Future<String> getStringFromFile(String fileName) async {
    var url =
        await FirebaseStorage.instance.ref().child(fileName).getDownloadURL();
    var response = await http.get(url);
    return response.body;
  }

  Future<StorageMetadata> getMetadataFromFile(String fileName) async {
    return await FirebaseStorage.instance.ref().child(fileName).getMetadata();
  }

  Future<int> getTimeUpdated(String fileName) async {
    var metaData = await getMetadataFromFile(fileName);
    return metaData.updatedTimeMillis;
  }
}

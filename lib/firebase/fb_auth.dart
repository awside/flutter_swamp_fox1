import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

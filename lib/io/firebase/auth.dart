import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:swamp_fox/helper/emitter.dart' as Emitter;

FirebaseAuth _auth;

setup() {
  _auth = FirebaseAuth.instance;
  _onAuthStateChanged();
}

_onAuthStateChanged() {
  _auth.onAuthStateChanged.listen((user) {
    Emitter.emit('AuthStateChanged', {'user': user ?? null});
  });
}

Future<FirebaseUser> getCurrentUser() async {
  return await _auth.currentUser();
}

signUp(String email, String password) async {
  try {
    await _auth.createUserWithEmailAndPassword(
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

signIn(String email, String password) async {
  try {
    await _auth.signInWithEmailAndPassword(
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

signOut() {
  _auth.signOut();
}

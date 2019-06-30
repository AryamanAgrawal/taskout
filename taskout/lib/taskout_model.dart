import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TaskoutModel extends Model {
  String username;
  String email;
  String password;
  bool signUp = false;
  FirebaseUser user;

  String get getUsername {
    return username;
  }

  String get getEmail {
    return email;
  }

  String get getPassword {
    return password;
  }

  //Google Sign Up
  FirebaseAuth _fAuth = FirebaseAuth.instance;
  GoogleSignIn _gSignIn = new GoogleSignIn();

  Future<bool> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();
    if (googleSignInAccount == null) {
      return false;
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      user = await _fAuth.signInWithCredential(credential);
      print("signed in " + user.displayName);
      return true;
    }
  }

  Future<String> signUpUser() async {
    try {
      user = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "";
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  Future<String> logInUser() async {
    try {
      user = await _fAuth.signInWithEmailAndPassword(email: email,password: password);
      return "";
    } on PlatformException catch (e) {
      return e.message;
    }
  }
}

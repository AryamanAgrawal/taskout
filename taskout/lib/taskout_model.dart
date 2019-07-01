import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TaskoutModel extends Model {
  bool isLoading = false;
  String username;
  String email;
  String password;
  bool signUpWithGoogle = false;
  FirebaseUser user;
  FirebaseAuth _fAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  GoogleSignIn _gSignIn = new GoogleSignIn();

  String get getUsername {
    return username;
  }

  String get getEmail {
    return email;
  }

  String get getPassword {
    return password;
  }

  bool get isSomethingLoading {
    return isLoading;
  }

  String get getLoggedInUserId {
    return user.uid;
  }

  void turnOffLoading() {
    isLoading = false;
    notifyListeners();
  }

  //Google Sign Up
  Future<String> signInWithGoogle() async {
    GoogleSignInAccount googleSignInAccount = await _gSignIn.signIn();
    if (googleSignInAccount == null) {
      return "Could not sign in with Google. Try Again.";
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      user = await _fAuth.signInWithCredential(credential);
      DocumentSnapshot ds =
          await _firestore.collection("users").document(user.uid).get();
      if (ds.exists) {
        return "";
      } else {
        if (signUpWithGoogle) {
          signUpWithGoogle = false;
          Map<String, dynamic> userData = {
            "username": username,
            "email": user.email,
            "uid": user.uid
          };
          try {
            _firestore.collection("users").document(user.uid).setData(userData);
            return "";
          } on PlatformException catch (e) {
            print(e.message);
            user.delete();
            return "Could not sign up. Try Again.";
          }
        } else {
          user.delete();
          print("no record");
          return "No records found for " + user.email + ". Sign up instead.";
        }
      }
    }
  }

  Future<String> signUpUser() async {
    isLoading = true;
    notifyListeners();
    String message;
    try {
      user = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      _firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .snapshots()
          .listen((data) {
        if (data.documents.length != 0) {
          isLoading = false;
          notifyListeners();
          message = "Username already exists. Choose a different username.";
        } else {
          Map<String, dynamic> userData = {
            "username": username,
            "email": email,
            "uid": user.uid
          };
          try {
            _firestore.collection("users").document(user.uid).setData(userData);
            isLoading = false;
            notifyListeners();
            message = "";
          } on PlatformException catch (e) {
            print(e.message);
            user.delete();
            isLoading = false;
            notifyListeners();
            message = "Could not sign up. Try Again";
          }
        }
      });
    } on PlatformException catch (e) {
      isLoading = false;
      notifyListeners();
      message = e.message;
    }
    return message;
  }

  Future<String> logInUser() async {
    isLoading = true;
    notifyListeners();
    try {
      user = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading = false;
      notifyListeners();
      return "";
    } on PlatformException catch (e) {
      isLoading = false;
      notifyListeners();
      return e.message;
    }
  }

  Future<bool> logOutUser() {
    print(user);
    return _fAuth.signOut().then((_) {
      return true;
    }).catchError((_) {
      return false;
    });
  }
}

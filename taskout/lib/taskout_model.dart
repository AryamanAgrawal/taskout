import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './models/task.dart';

class TaskoutModel extends Model {
  String username;
  String email;
  String password;
  bool signUpWithGoogle = false;
  FirebaseUser user;
  FirebaseAuth _fAuth = FirebaseAuth.instance;
  Firestore _firestore = Firestore.instance;
  GoogleSignIn _gSignIn = new GoogleSignIn();
  Map<String, dynamic> signedInUserDetails;
  String signedInUsername;
  bool _clickedNewTask = false;
  String _usernameForTask;

  String get usernameForTask {
    return _usernameForTask;
  }

  void setUsernameForTask(String value) {
    _usernameForTask = value;
  }

  bool get clickedNewTask {
    return _clickedNewTask;
  }

  void toggleAddTask() {
    _clickedNewTask = !_clickedNewTask;
    notifyListeners();
  }

  String get getUsername {
    return username;
  }

  String get getEmail {
    return email;
  }

  String get getPassword {
    return password;
  }

  String get getUserId {
    return user.uid;
  }

  Map<String, dynamic> get signedInUserDetailsMap {
    return signedInUserDetails;
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
        String userDetailsSet = await setSignedInUserDetails();
        return userDetailsSet;
      } else {
        if (signUpWithGoogle) {
          signUpWithGoogle = false;
          Map<String, dynamic> userData = {
            "username": username,
            "email": user.email,
            "uid": user.uid
          };
          signedInUserDetails = userData;
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

  //Sign Up new users
  Future<String> signUpUser() async {
    try {
      user = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      QuerySnapshot qs = await _firestore
          .collection("users")
          .where("username", isEqualTo: username)
          .getDocuments();
      if (qs.documents.length != 0) {
        return "Username already exists. Choose a different username.";
      } else {
        Map<String, dynamic> userData = {
          "username": username,
          "email": email,
          "uid": user.uid
        };
        _firestore.collection("users").document(user.uid).setData(userData);
        signedInUserDetails = userData;
        return "";
      }
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  //log in existing user
  Future<String> logInUser() async {
    try {
      user = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      String userDetailsSet = await setSignedInUserDetails();
      return userDetailsSet;
    } on PlatformException catch (e) {
      return e.message;
    }
  }

  //logout signed in user
  Future<bool> logOutUser() {
    print(user);
    return _fAuth.signOut().then((_) {
      return true;
    }).catchError((_) {
      return false;
    });
  }

  Future<String> setSignedInUserDetails() async {
    try {
      DocumentSnapshot ds =
          await _firestore.collection("users").document(user.uid).get();
      signedInUserDetails = ds.data;
      return "";
    } on PlatformException catch (e) {
      print(e.message);
      return "Could not load your data. Try Again.";
    }
  }

  //save new task
  Future<String> addNewTask(CustomTask task) async {
    try {
      Map<String, dynamic> dataToPut = task.taskData;
      if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(dataToPut["to"])) {
        QuerySnapshot qs = await _firestore
            .collection("users")
            .where("username", isEqualTo: dataToPut["to"])
            .getDocuments();
        if (qs.documents.length == 0) {
          return "Recipient username not found. Try again or task them out through email.";
        }
      }
      await _firestore.collection("tasks").add(dataToPut);
      return "added";
    } on PlatformException catch (e) {
      return e.message;
    }
  }
}

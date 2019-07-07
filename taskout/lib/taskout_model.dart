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
  FirebaseUser user;
  FirebaseAuth _fAuth = FirebaseAuth.instance;
  Map<String, dynamic> signedInUserDetailsMap;
  Firestore _firestore = Firestore.instance;
  Function toggleNewTaskThroughModel;
  Function toggleTaskAlertThroughModel;

  //STARTS: Handling username filling for adding task through favorite
  String _usernameForTask;

  String get usernameForTask {
    return _usernameForTask;
  }

  void setUsernameForTask(String value) {
    _usernameForTask = value;
  }
  //ENDS: Handling username filling for adding task through favorite

  //STARTS: Getting signed in user's details
  Future<String> setSignedInUserDetails() async {
    try {
      DocumentSnapshot ds =
          await _firestore.collection("users").document(user.uid).get();
      signedInUserDetailsMap = ds.data;
      return "";
    } on PlatformException catch (e) {
      print(e.message);
      return "Could not load your data. Try Again.";
    }
  }
  //STOPS: Getting signed in user's details

  //STARTS: Google Sign Up and Logging in
  bool signUpWithGoogle = false;
  GoogleSignIn _gSignIn = new GoogleSignIn();

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
      //Check if records already exist
      DocumentSnapshot ds =
          await _firestore.collection("users").document(user.uid).get();
      if (ds.exists) {
        //User exists so sign in and fetch details
        String userDetailsSet = await setSignedInUserDetails();
        return userDetailsSet;
      } else {
        //User does not already exist. Check if they are signing up or trying to log in
        if (signUpWithGoogle) {
          signUpWithGoogle = false;
          Map<String, dynamic> userData = {
            "username": username,
            "email": user.email,
            "uid": user.uid
          };
          signedInUserDetailsMap = userData;
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
  //STOPS: Google Sign Up and Logging in

  //STARTS: Sign Up new users
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
        signedInUserDetailsMap = userData;
        return "";
      }
    } on PlatformException catch (e) {
      return e.message;
    }
  }
  //STOPS: Sign Up new users
  

  //STARTS: Log in existing user
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
  //STOPS: Log in existing user

  //STARTS: Logout signed in user
  Future<bool> logOutUser() {
    print(user);
    return _fAuth.signOut().then((_) {
      return true;
    }).catchError((_) {
      return false;
    });
  }
  //STOPS: Logout signed in user

  //STARTS: Save new task
  Future<String> addNewTask(CustomTask task) async {
    try {
      Map<String, dynamic> dataToPut = task.taskData;
      List<Map<String, dynamic>> updates = [{
        "status": "Requested",
        "time": dataToPut["created"],
        "color": "grey"
      }];
      dataToPut["updates"] = updates;
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
  //STOPS: Save new task
}

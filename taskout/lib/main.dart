import 'package:flutter/material.dart';
import './pages/login.dart';
import 'package:scoped_model/scoped_model.dart';
import './taskout_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pages/pages_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  FirebaseAuth _fAuth = FirebaseAuth.instance;
  bool isLoggedIn = false;
  bool checkComplete = false;
  TaskoutModel model = TaskoutModel();
  @override
  void initState() {
    super.initState();
    _fAuth.currentUser().then((FirebaseUser currentUser) {
      if (currentUser != null) {
        model.user = currentUser;
        model.setSignedInUserDetails().then((String value) {
          if (value == "") {
            setState(() {
              checkComplete = true;
              isLoggedIn = true;
            });
          }
        });
      }else{
        setState(() {
          checkComplete = true;
        });
      }
    });
  }

  Widget _whatToDisplay() {
    if (checkComplete) {
      if (isLoggedIn) {
        return PagesManager();
      } else {
        return LogIn();
      }
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "productsans",
          primaryColor: Colors.black,
          accentColor: Colors.black,
          highlightColor: Colors.black,
          cursorColor: Colors.black,
        ),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xfffafafa),
          body: _whatToDisplay(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import './pages/login.dart';
import 'package:scoped_model/scoped_model.dart';
import './taskout_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './pages/something.dart';

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
  TaskoutModel model = TaskoutModel();
  @override
  void initState() {
    super.initState();
    _fAuth.currentUser().then((FirebaseUser currentUser) {
      if (currentUser != null) {
        model.user = currentUser;
        setState(() {
          isLoggedIn = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: model,
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "productsans",
        ),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xfffafafa),
          body: isLoggedIn ? Something() : LogIn(),
        ),
      ),
    );
  }
}

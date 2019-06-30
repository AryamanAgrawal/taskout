import 'package:flutter/material.dart';
import './pages/login.dart';
import 'package:scoped_model/scoped_model.dart';
import './taskout_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: TaskoutModel(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: "productsans",
        ),
        home: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Color(0xfffafafa),
          body: LogIn(),
        ),
      ),
    );
  }
}

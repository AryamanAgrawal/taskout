import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../taskout_model.dart';
import '../../main.dart';

class UserPreferences extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UserPreferencesState();
  }
}

class _UserPreferencesState extends State<UserPreferences> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TaskoutModel>(
      builder: (BuildContext context, Widget child, TaskoutModel model) {
        return Center(
          child: RaisedButton(
            onPressed: () {
              model.logOutUser().then((bool value) {
                if (value) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => MyApp()));
                }
              });
            },
            child: Text("Logout"),
          ),
        );
      },
    );
  }
}

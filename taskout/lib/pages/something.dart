import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskout/taskout_model.dart';
import '../main.dart';

class Something extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<TaskoutModel>(
        builder: (BuildContext context, Widget child, TaskoutModel model) {
          return Center(
            child: RaisedButton(
              child: Text("Log Out"),
              onPressed: () {
                model.logOutUser().then((bool result) {
                  if (result) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MyApp()));
                  } else {
                    print("Unable to sign out");
                  }
                });
              },
            ),
          );
        },
      ),
    );
  }
}

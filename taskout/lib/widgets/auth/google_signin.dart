import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../taskout_model.dart';
import '../../pages/pages_manager.dart';
import '../general/custom_alert_dialog.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0.5,
      borderRadius: BorderRadius.circular(30.0),
      child: Container(
        child: ScopedModelDescendant<TaskoutModel>(
          builder: (BuildContext context, Widget child, TaskoutModel model) {
            return FlatButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image(
                    image: AssetImage("assets/icons/google.png"),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    "PROCEED WITH GOOGLE",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
              onPressed: () {
                model.signInWithGoogle().then((String message) {
                  print("padamchopra: " + message);
                  if (message == null || message.length == 0) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => PagesManager()));
                  } else {
                    CustomAlertDialog().buildCustomAlertDialog(context, "Google Sign-In", message);
                  }
                });
              },
            );
          },
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.black12,
            width: 0.5,
          ),
        ),
      ),
    );
  }
}

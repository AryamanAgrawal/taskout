import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../taskout_model.dart';
import '../../pages/something.dart';

class GoogleSignInButton extends StatelessWidget {
  void _buildErrorDisplayingDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Log In"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("DISMISS"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

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
                model.signInWithGoogle().then((bool value) {
                  if (value) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) => Something()));
                  } else {
                    _buildErrorDisplayingDialog(
                        context, "Could not continue with Google. Try Again.");
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

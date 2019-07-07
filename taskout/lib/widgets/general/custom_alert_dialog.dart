import 'package:flutter/material.dart';

class CustomAlertDialog {
  void buildCustomAlertDialog(
      BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                margin: EdgeInsets.only(right: 10.0, bottom: 10.0),
                padding: EdgeInsets.all(7.0),
                child: Text(
                  "Dismiss",
                  style: TextStyle(
                    color: Color(0xff4A69FF),
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff4A69FF),
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class ConfirmAuthButton extends StatelessWidget {
  final String buttonText;
  final Function function;
  ConfirmAuthButton(this.buttonText, this.function);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 35.0,
        vertical: 8.0,
      ),
      child: Align(
        alignment: FractionalOffset.centerRight,
        child: Container(
          child: FlatButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  width: 3.0,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 14.0,
                ),
                SizedBox(
                  width: 4.0,
                ),
              ],
            ),
            onPressed: function,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            gradient: LinearGradient(
              begin: FractionalOffset.centerLeft,
              end: FractionalOffset.centerRight,
              colors: <Color>[Color(0xff4A69FF), Color(0xff4AD284)],
            ),
          ),
        ),
      ),
    );
  }
}

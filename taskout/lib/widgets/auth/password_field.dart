import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 35.0,
        vertical: 8.0,
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Color(0xffC7D0F8),
        child: TextFormField(
          validator: (String value) {
            if (value.isEmpty) {
              return "Please enter a password";
            } else if (value.length < 6) {
              return "Needs to be 6 characters or more";
            }
          },
          obscureText: true,
          cursorColor: Colors.blue.shade900,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black26),
            suffixIcon: Icon(
              Icons.lock_outline,
              color: Color(0xff4AD284),
              //color: Color(0xffcccccc),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            labelText: "Password",
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

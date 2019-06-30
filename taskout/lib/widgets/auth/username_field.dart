import 'package:flutter/material.dart';

class UsernameTextField extends StatelessWidget {
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
              return "Please provide an email";
            } else if (value.split(" ").length > 1) {
              return "Username should be one word";
            }
          },
          cursorColor: Colors.blue.shade900,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black26),
            suffixIcon: Icon(
              Icons.person_outline,
              color: Color(0xff4A69FF),
              //color: Color(0xffcccccc),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            labelText: "Username",
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

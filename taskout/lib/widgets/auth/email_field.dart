import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
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
            } else if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return "Invalid email";
            }
          },
          keyboardType: TextInputType.emailAddress,
          cursorColor: Colors.blue.shade900,
          decoration: InputDecoration(
            labelStyle: TextStyle(color: Colors.black26),
            suffixIcon: Icon(
              Icons.alternate_email,
              color: Color(0xff4A69FF),
            ),
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
            labelText: "Email",
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

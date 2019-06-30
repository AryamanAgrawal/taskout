import 'package:flutter/material.dart';
import '../../taskout_model.dart';

class PasswordTextField extends StatelessWidget {
  final TaskoutModel taskoutModel;
  PasswordTextField(this.taskoutModel);

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
        child: TextField(
          onChanged: (String value){
            taskoutModel.password = value;
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

import 'package:flutter/material.dart';
import '../../taskout_model.dart';

class UsernameTextField extends StatelessWidget {
  final TaskoutModel taskoutModel;
  final bool shouldHavePadding;
  UsernameTextField(this.taskoutModel, {this.shouldHavePadding});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: shouldHavePadding==null ? 35.0 : 5.0,
        vertical: 8.0,
      ),
      child: Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Color(0xffC7D0F8),
        child: TextField(
          autocorrect: false,
          onChanged: (String value){
            taskoutModel.username = value;
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

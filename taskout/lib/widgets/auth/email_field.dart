import 'package:flutter/material.dart';
import '../../taskout_model.dart';

class EmailTextField extends StatelessWidget {
  final TaskoutModel taskoutModel;
  EmailTextField(this.taskoutModel);

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
          autocorrect: false,
          onChanged: (String value){
            taskoutModel.email = value;
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

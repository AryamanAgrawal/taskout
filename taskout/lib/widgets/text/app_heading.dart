import 'package:flutter/material.dart';

class AppHeading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      "Taskout",
      style: TextStyle(
        fontSize: 36.0,
        color: Color(0xff4A69FF),
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  Heading(this.text,this.color,{this.fontSize = 36.0});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

import 'package:flutter/material.dart';

class Subheading extends StatelessWidget{
  final String text;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  Subheading(this.text, this.color, {this.textAlign = TextAlign.end, this.fontSize = 15.0});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: fontSize, color: color),
    );
  }
}
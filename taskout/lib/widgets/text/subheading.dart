import 'package:flutter/material.dart';

class Subheading extends StatelessWidget{
  final String text;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final TextDecoration textDecoration;
  Subheading(this.text, this.color, {this.textAlign = TextAlign.end, this.fontSize = 15.0, this.textDecoration = TextDecoration.none});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: fontSize, color: color, decoration: textDecoration, decorationStyle: TextDecorationStyle.dotted),
    );
  }
}
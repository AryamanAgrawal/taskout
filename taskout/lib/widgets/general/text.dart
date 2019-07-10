import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final TextAlign textAlign;
  Heading(this.text,this.color,{this.fontSize = 36.0, this.textAlign = TextAlign.center});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.bold,
      ),
      textAlign: textAlign,
    );
  }
}

class Subheading extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final TextDecoration textDecoration;
  Subheading(this.text, this.color,
      {this.textAlign = TextAlign.end,
      this.fontSize = 15.0,
      this.textDecoration = TextDecoration.none});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        decoration: textDecoration,
        decorationStyle: TextDecorationStyle.dotted,
      ),
    );
  }
}

class CaptionText extends StatelessWidget {
  final String text;
  final Color color;
  final TextAlign textAlign;
  CaptionText(this.text, this.color, {this.textAlign = TextAlign.end});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(fontSize: 12.0, color: color),
    );
  }
}

import 'package:flutter/material.dart';

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

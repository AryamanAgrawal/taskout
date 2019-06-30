import 'package:flutter/material.dart';

class CaptionText extends StatelessWidget {
  final String text;
  final Color color;
  CaptionText(this.text, this.color);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.end,
      style: TextStyle(fontSize: 12.0, color: color),
    );
  }
}

import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color bgcolor;
  final Color textcolor;
  final double fontSize;
  final double leftMargin;
  final double rightMargin;
  CustomChip(this.text, this.bgcolor,
      {this.textcolor = Colors.black, this.fontSize = 10.0, this.leftMargin = 0.0, this.rightMargin = 0.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      child: Chip(
        label: Text(text),
        backgroundColor: bgcolor,
        labelStyle: TextStyle(fontSize: fontSize, color: textcolor),
      ),
    );
  }
}

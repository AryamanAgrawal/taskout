import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color bgcolor;
  final Color textcolor;
  final double fontSize;
  final double leftMargin;
  final double rightMargin;
  final IconData iconData;
  CustomChip(this.text, this.bgcolor,
      {this.textcolor = Colors.black,
      this.fontSize = 10.0,
      this.leftMargin = 0.0,
      this.rightMargin = 0.0,
      this.iconData});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: leftMargin, right: rightMargin),
      child: iconData != null
          ? Chip(
              avatar: Container(
                margin: EdgeInsets.only(left: 5.0),
                child: Icon(iconData, color: Colors.white, size: 20.0,),
              ),
              label: Text(text),
              backgroundColor: bgcolor,
              labelStyle: TextStyle(fontSize: fontSize, color: textcolor),
            )
          : Chip(
              label: Text(text),
              backgroundColor: bgcolor,
              labelStyle: TextStyle(fontSize: fontSize, color: textcolor),
            ),
    );
  }
}

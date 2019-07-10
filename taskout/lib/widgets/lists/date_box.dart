import 'package:flutter/material.dart';
import '../general/text.dart';

class DateBox extends StatelessWidget {
  final String day;
  final String date;
  final bool selected;
  DateBox(this.day, this.date, {this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 62,
      height: 62,
      decoration: BoxDecoration(
        color: selected ? Color(0xff4A69FF) : Color(0xffeceefd),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Subheading(
            day,
            selected ? Colors.white : Color(0xff4A69FF),
            fontSize: 10.0,
          ),
          Heading(
            date.length==1 ? "0" + date : date,
            selected ? Colors.white : Color(0xff4A69FF),
            fontSize: 20.0,
          )
        ],
      ),
    );
  }
}

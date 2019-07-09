import 'package:flutter/material.dart';

class PriorityTag extends StatelessWidget {
  final String priority;
  PriorityTag({@required this.priority});

  @override
  Widget build(BuildContext context) {
    Color tagColor;
    switch (priority) {
      case 'Urgent': tagColor = Colors.red; break;
      case 'Moderate': tagColor = Colors.amber; break;
      case 'Casual': tagColor = Colors.green; break;
      default: break;
    }
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: tagColor,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      child: Text(
        priority,
        style: TextStyle(color: Colors.white, fontSize: 15.0),
      ),
    );
  }
}

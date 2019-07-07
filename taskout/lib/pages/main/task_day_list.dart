import 'package:flutter/material.dart';

class TaskDayList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _TaskDayListState();
  }
}

class _TaskDayListState extends State<TaskDayList>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Task Day List"),
    );
  }
}
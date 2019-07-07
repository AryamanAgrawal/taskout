import 'package:flutter/material.dart';

class OutsourcedTaskList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _OutsourcedTaskListState();
  }
}

class _OutsourcedTaskListState extends State<OutsourcedTaskList>{
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Task Day List"),
    );
  }
}
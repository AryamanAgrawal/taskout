import 'package:flutter/material.dart';
import '../../widgets/general/circle_progress_bar.dart';

class ReceivedTaskList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ReceivedTaskListState();
  }
}

class _ReceivedTaskListState extends State<ReceivedTaskList> {
  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: CircleProgressBar(
          foregroundColor: Color(0xff4A69FF),
          value: 0.2,
          backgroundColor: Colors.grey.shade200,
        ),
      ),
    );
  }
}

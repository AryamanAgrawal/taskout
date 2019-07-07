import 'package:flutter/material.dart';

class PriorityButtons extends StatefulWidget {
  int taskPriority;

  @override
  State<StatefulWidget> createState() {
    return _PriorityButtonsState();
  }
}

class _PriorityButtonsState extends State<PriorityButtons> {
  Widget _buildPriorityButton(String text, int index) {
    List<Color> colorsList = [
      Colors.grey.shade300,
      Colors.red.shade500,
      Colors.blue.shade500,
      Colors.green.shade500
    ];
    BorderRadiusGeometry borderRadiusGeometryForUrgent = BorderRadius.only(
      topLeft: Radius.circular(10.0),
      bottomLeft: Radius.circular(10.0),
    );
    BorderRadiusGeometry borderRadiusGeometryForCasual = BorderRadius.only(
      topRight: Radius.circular(10.0),
      bottomRight: Radius.circular(10.0),
    );
    BorderRadiusGeometry borderRadiusGeometryForAll =
        BorderRadius.circular(0.0);
    BorderRadiusGeometry toApply = borderRadiusGeometryForAll;
    if (index == 1) {
      toApply = borderRadiusGeometryForUrgent;
    } else if (index == 3) {
      toApply = borderRadiusGeometryForCasual;
    }
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.taskPriority = index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: toApply,
            color: widget.taskPriority == index ? colorsList[index] : colorsList[0],
          ),
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            text,
            style: TextStyle(
              color: widget.taskPriority == index ? Colors.white : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _buildPriorityButton("Urgent", 1),
        _buildPriorityButton("Moderate", 2),
        _buildPriorityButton("Casual", 3),
      ],
    );
  }
}

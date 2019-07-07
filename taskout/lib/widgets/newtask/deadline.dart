import 'package:flutter/material.dart';

class Deadline extends StatefulWidget {
  DateTime selectedDate = DateTime.now();
  bool dateIsSelected = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool timeIsSelected = false;
  @override
  State<StatefulWidget> createState() {
    return _DeadlineState();
  }
}

class _DeadlineState extends State<Deadline> {
  String _formatDate(DateTime toFormat) {
    String day = toFormat.day.toString();
    String month = toFormat.month.toString();
    String year = toFormat.year.toString();
    day = day.length == 1 ? "0" + day : day;
    month = month.length == 1 ? "0" + month : month;
    return day + "-" + month + "-" + year;
  }

  void _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.selectedDate,
      firstDate: DateTime(widget.selectedDate.year, widget.selectedDate.month),
      lastDate: DateTime(2100),
    );
    if (picked != null)
      setState(() {
        widget.dateIsSelected = true;
        widget.selectedDate = picked;
      });
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (picked != null)
      setState(() {
        widget.timeIsSelected = true;
        widget.selectedTime = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.only(right: 10.0),
            child: RaisedButton(
              color: widget.dateIsSelected
                  ? Colors.blueAccent.shade100
                  : Colors.grey.shade100,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(26.0),
              ),
              onPressed: () {
                _selectDate(context);
              },
              child: Text(widget.dateIsSelected
                  ? _formatDate(widget.selectedDate)
                  : "Select Date"),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 10.0),
            child: RaisedButton(
              color: widget.timeIsSelected
                  ? Colors.blueAccent.shade100
                  : Colors.grey.shade100,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(26.0),
              ),
              onPressed: () {
                _selectTime(context);
              },
              child: Text(widget.timeIsSelected
                  ? widget.selectedTime.format(context)
                  : "Select Time"),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:async';
import '../widgets/text/heading.dart';
import '../widgets/text/subheading.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AddTaskState();
  }
}

class _AddTaskState extends State<AddTask> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final List<String> tags = [];
  DateTime selectedDate = DateTime.now();
  bool dateIsSelected = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool timeIsSelected = false;
  
  
  String _formatDate(DateTime toFormat){
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
      initialDate: selectedDate,
      firstDate: DateTime(selectedDate.year, selectedDate.month),
      lastDate: DateTime(2100),
    );
    if (picked != null)
      setState(() {
        dateIsSelected = true;
        selectedDate = picked;
      });
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );
    if (picked != null)
      setState(() {
        timeIsSelected = true;
        selectedTime = picked;
        print(picked);
      });
  }

  void _addTag(String tag) {
    setState(() {
      tags.add(tag);
    });
  }

  void _removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  Widget _buildTagChip(IconData icon, String tag, Color selectedColor) {
    return Container(
      margin: EdgeInsets.only(
        right: 10.0,
      ),
      child: RawChip(
        label: Text(tag),
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        labelPadding: EdgeInsets.only(left: 0.0, right: 5.0),
        backgroundColor: tags.contains(tag) ? selectedColor : Colors.white,
        avatar: Icon(
          icon,
          size: 20.0,
          color: tags.contains(tag) ? Colors.black : Colors.black54,
        ),
        shape: StadiumBorder(
          side: BorderSide(width: 0.1),
        ),
        elevation: 1.0,
        onPressed: () {
          tags.contains(tag) ? _removeTag(tag) : _addTag(tag);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Heading(
          "Add Task",
          Colors.black,
          fontSize: 26.0,
        ),
        SizedBox(
          height: 20.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  cursorColor: Colors.black,
                  autocorrect: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: "Recipent's Username/Email",
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  autocorrect: false,
                  maxLines: 1,
                  decoration: InputDecoration(
                    labelText: "Title",
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  cursorColor: Colors.black,
                  autocorrect: false,
                  maxLines: 5,
                  maxLength: 200,
                  decoration: InputDecoration(
                    labelText: "Description",
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.all(5.0),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Subheading(
                  "Tags",
                  Colors.black,
                ),
                SizedBox(
                  height: 7.0,
                ),
                Container(
                  height: 40.0,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _buildTagChip(Icons.home, "Home", Colors.blue.shade100),
                      _buildTagChip(Icons.work, "Work", Colors.blue.shade200),
                      _buildTagChip(Icons.person_outline, "Personal",
                          Colors.blue.shade300),
                      _buildTagChip(
                          Icons.adjust, "Others", Colors.blue.shade400),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Subheading(
                  "Deadline",
                  Colors.black,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(right: 10.0),
                        child: RaisedButton(
                          color: Colors.blueAccent.shade100,
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                          onPressed: () {
                            _selectDate(context);
                          },
                          child: Text(dateIsSelected ? _formatDate(selectedDate) : "Select Date"),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.0),
                        child: RaisedButton(
                          shape: ContinuousRectangleBorder(
                            borderRadius: BorderRadius.circular(26.0),
                          ),
                          onPressed: () {
                            _selectTime(context);
                          },
                          child: Text("Select Time"),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

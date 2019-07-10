import 'dart:async';
import 'package:flutter/material.dart';
import './text.dart';
import './custom_chip.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../taskout_model.dart';

class TaskAlert extends StatefulWidget {
  final Function toggle;
  TaskAlert({this.toggle});

  @override
  State<StatefulWidget> createState() {
    return _TaskAlertState();
  }
}

class _TaskAlertState extends State<TaskAlert> {
  double translateY = 400.0;

  void _dismissAlert() {
    setState(() {
      translateY = 500.0;
    });
    Timer(Duration(milliseconds: 460), () {
      widget.toggle();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 300), () {
      setState(() {
        translateY = 0.0;
      });
    });
  }

  Color getColor(int priority) {
    if (priority == 1) {
      return Colors.red.shade500;
    } else if (priority == 2) {
      return Colors.blue.shade500;
    } else if (priority == 3) {
      return Colors.green.shade500;
    } else {
      return Colors.black;
    }
  }

  String getDueBy(DateTime datetime) {
    String year = datetime.year.toString();
    String month;
    switch (datetime.month) {
      case 1:
        month = "January";
        break;
      case 2:
        month = "February";
        break;
      case 3:
        month = "March";
        break;
      case 4:
        month = "April";
        break;
      case 5:
        month = "May";
        break;
      case 6:
        month = "June";
        break;
      case 7:
        month = "July";
        break;
      case 8:
        month = "August";
        break;
      case 9:
        month = "September";
        break;
      case 10:
        month = "October";
        break;
      case 11:
        month = "November";
        break;
      case 12:
        month = "December";
        break;
      default:
        month = "-";
        break;
    }
    String date = datetime.day.toString();
    int hourInt = datetime.hour;
    String minute = datetime.minute.toString();
    String meridian = hourInt >= 12 ? "PM" : "AM";
    hourInt = hourInt > 12 ? hourInt - 12 : hourInt;
    String hour = hourInt.toString();
    hour = hour.length == 1 ? "0" + hour : hour;
    minute = minute.length == 1 ? "0" + minute : minute;
    return hour +
        ":" +
        minute +
        " " +
        meridian +
        " on " +
        date +
        " " +
        month +
        " " +
        year;
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TaskoutModel>(
      builder: (BuildContext context, Widget child, TaskoutModel model) {
        Map<String, dynamic> data = model.selectedTask.taskData;
        return Align(
          alignment: FractionalOffset.bottomCenter,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 450),
            curve: Curves.easeInBack,
            transform: Matrix4.translationValues(0.0, translateY, 0.0),
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 2.0,
                  offset: Offset(0.0, -3.0),
                )
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.assignment,
                      color: getColor(
                          data.containsKey("priority") ? data["priority"] : 4),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Heading(
                      data["title"],
                      Colors.black,
                      fontSize: 18.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Heading(
                            "From:",
                            Colors.black,
                            fontSize: 15.0,
                          ),
                          Subheading(data["from"], Colors.black)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Heading(
                            "To:",
                            Colors.black,
                            fontSize: 15.0,
                          ),
                          Subheading(data["to"], Colors.black)
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: CaptionText(
                    data["description"],
                    Colors.black87,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: <Widget>[
                    Heading(
                      "Due by:",
                      Colors.black,
                      fontSize: 15.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Subheading(
                        getDueBy(DateTime.fromMillisecondsSinceEpoch(
                            data["deadline"])),
                        Colors.black)
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                data.containsKey("tags")
                    ? Row(
                        children: List.from(data["tags"]).map((value) {
                          IconData iconData = Icons.adjust;
                          if(value.toString() == "Home"){
                            iconData = Icons.home;
                          } else if(value.toString() == "Work"){
                            iconData = Icons.work;
                          } else if(value.toString() == "Personal"){
                            iconData = Icons.person;
                          }
                          return CustomChip(
                            value.toString(),
                            Colors.black,
                            rightMargin: 8.0,
                            textcolor: Colors.white,
                            iconData: iconData,
                          );
                        }).toList(),
                        /*<Widget>[
                    CustomChip(
                      "Home",
                      Colors.black,
                      rightMargin: 8.0,
                      textcolor: Colors.white,
                      iconData: Icons.home,
                    ),
                    CustomChip(
                      "Personal",
                      Colors.black,
                      textcolor: Colors.white,
                      iconData: Icons.work,
                    )
                  ]*/
                      )
                    : Container(),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    OutlineButton(
                      //TODO: Add function to reject task
                      onPressed: _dismissAlert,
                      child: Subheading(
                        model.negativeAlertButtonText,
                        Colors.black,
                        fontSize: 12.0,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      borderSide: BorderSide(color: Colors.black, width: 1.0),
                    ),
                    FlatButton(
                      //TODO: Add function to accept task
                      onPressed: _dismissAlert,
                      child: Subheading(
                        model.positiveAlertButtonText,
                        Colors.white,
                        fontSize: 12.0,
                      ),
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

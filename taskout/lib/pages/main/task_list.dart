import 'dart:io';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../taskout_model.dart';
import '../../widgets/general/text.dart';
import '../../widgets/general/fullwidth.dart';
import '../../widgets/lists/date_box.dart';
import '../../widgets/lists/task_tile.dart';
import '../../models/task.dart';

class TaskList extends StatefulWidget {
  final String mode;
  TaskList({@required this.mode});

  @override
  State<StatefulWidget> createState() {
    return _TaskListState();
  }
}

class _TaskListState extends State<TaskList> {
  DateTime now = DateTime.now();
  int selectedIndex = 0;
  ScrollController scrollController = ScrollController();
  List<CustomTask> taskListToUse;
  int previousIndex = 0;
  int nextIndex = 0;

  Widget _addGap(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  void refreshStateOfList() {
    setState(() {
      print("refreshed");
    });
  }

  String getMonth(int monthNumber) {
    String month;
    switch (monthNumber) {
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
    return month;
  }

  String todaysdate(int monthNumber) {
    return (" " +
        now.day.toString() +
        " " +
        getMonth(monthNumber).toUpperCase() +
        " " +
        now.year.toString());
  }

  String getDayofWeek(int index) {
    int dayNumberOfWeek = now.weekday + index % 7;
    dayNumberOfWeek =
        dayNumberOfWeek > 7 ? dayNumberOfWeek % 7 : dayNumberOfWeek;
    switch (dayNumberOfWeek) {
      case 1:
        return "MON";
        break;
      case 2:
        return "TUE";
        break;
      case 3:
        return "WED";
        break;
      case 4:
        return "THU";
        break;
      case 5:
        return "FRI";
        break;
      case 6:
        return "SAT";
        break;
      case 7:
        return "SUN";
        break;
      default:
        return "-";
        break;
    }
  }

  int numberOfDaysInMonth() {
    switch (now.month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
        break;
      case 2:
        if (now.year % 4 == 0) {
          return 29;
        } else {
          return 28;
        }
        break;
      default:
        return 30;
        break;
    }
  }

  int _getTodaysDate(int numberToAdd) {
    String day = (DateTime.now().day + selectedIndex + numberToAdd).toString();
    String month = now.month.toString();
    String year = now.year.toString();
    day = day.length == 1 ? "0" + day : day;
    month = month.length == 1 ? "0" + month : month;
    return DateTime.parse(year + "-" + month + "-" + day + " 00:00:00.000")
        .millisecondsSinceEpoch;
  }

  String deadlineTime(int hour, int minutes) {
    String meridian = "AM";
    if (hour > 12) {
      hour = hour - 12;
      meridian = "PM";
    } else if (hour == 12) {
      meridian = "PM";
    }
    String hourString = hour.toString();
    String minuteString = minutes.toString();
    hourString = hourString.length == 1 ? "0" + hourString : hourString;
    minuteString = minuteString.length == 1 ? "0" + minuteString : minuteString;
    return hourString + ":" + minuteString + " " + meridian;
  }

  void sortList() {
    int forDayToStartView = _getTodaysDate(0);
    int forDayToEndView = _getTodaysDate(1);
    bool taskForDayExists = false;
    if (selectedIndex == 0 && taskListToUse.length > 0) {
      taskForDayExists = true;
      previousIndex = 0;
    } else {
      try {
        taskForDayExists = true;
        previousIndex =
            taskListToUse.indexOf(taskListToUse.firstWhere((CustomTask task) {
          return task.taskData["deadline"] >= forDayToStartView &&
              task.taskData["deadline"] < forDayToEndView;
        }));
      } on StateError {
        previousIndex = 0;
        taskForDayExists = false;
      }
    }
    try {
      nextIndex =
          taskListToUse.indexOf(taskListToUse.firstWhere((CustomTask task) {
        return task.taskData["deadline"] >= forDayToEndView;
      }));
    } on StateError {
      nextIndex = previousIndex;
    }
    if (nextIndex - previousIndex == 0 && taskForDayExists == true) {
      nextIndex += 1;
    } else if (taskForDayExists == false) {
      nextIndex = 0;
      previousIndex = 0;
    }
  }

  Widget _buildTaskTile(BuildContext context, int index, TaskoutModel model) {
    Map<String, dynamic> currentTask = {};
    Color color;
    String deadline;
    bool hasPassed = false;
    index = previousIndex + index;
    if (index != nextIndex) {
      currentTask = taskListToUse[index].taskData;
      if (currentTask.containsKey("priority")) {
        if (currentTask["priority"] == 1) {
          color = Colors.red.shade500;
        } else if (currentTask["priority"] == 2) {
          color = Colors.blue.shade500;
        } else {
          color = Colors.green.shade500;
        }
      }
      if (currentTask.containsKey("deadline")) {
        DateTime currentDateTime =
            DateTime.fromMicrosecondsSinceEpoch(currentTask["deadline"] * 1000);
        TimeOfDay timeOfDay = TimeOfDay.fromDateTime(currentDateTime);
        deadline = deadlineTime(timeOfDay.hour, timeOfDay.minute);
        if (currentDateTime.isBefore(DateTime.now())) {
          hasPassed = true;
          deadline = deadline +
              " on " +
              currentDateTime.day.toString() +
              " " +
              getMonth(currentDateTime.month);
        }
      }
    }
    if (index == nextIndex) {
      return CaptionText(
        "\n${nextIndex - previousIndex} taskouts for today\n\n",
        Colors.black45,
        textAlign: TextAlign.center,
      );
    } else {
      return GestureDetector(
        onTap: () {
          model.generateAlert(taskListToUse[index], "DISMISS", "VIEW MORE");
          model.toggleTaskAlertThroughModel();
        },
        child: TaskTile(
          title: currentTask["title"],
          status: currentTask["updates"][currentTask["updates"].length - 1]
              ["status"],
          toOrFrom: widget.mode == "Received"
              ? "From: ${currentTask['from']}"
              : "To: ${currentTask['to']}",
          color: color,
          deadlinetime: deadline == "00:00 AM" ? null : deadline,
          hasPassed: hasPassed,
        ),
      );
    }
  }
  //TODO: Remove this comment
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(bottom: 10.0),
      color: Colors.white, //Color(0xfff9fafc),
      child: ScopedModelDescendant<TaskoutModel>(
        builder: (BuildContext context, Widget child, TaskoutModel model) {
          model.refreshTaskList = refreshStateOfList;
          if (widget.mode == "Received") {
            taskListToUse = model.receivedTasks;
          } else {
            taskListToUse = model.outsourcedTasks;
          }
          sortList();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                elevation: 3.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Platform.isIOS ? _addGap(90.0, 0.0) : _addGap(50.0, 0.0),
                      FullWidth(
                        padding: 20.0,
                        widget: Subheading(
                          todaysdate(now.month),
                          Colors.black54,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      _addGap(10.0, 0.0),
                      FullWidth(
                        padding: 20.0,
                        widget: Heading(
                          widget.mode + " Tasks",
                          Colors.black,
                          fontSize: 34.0,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      _addGap(24.0, 0.0),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        padding: EdgeInsets.only(left: 12.0),
                        child: ListView.builder(
                          controller: scrollController,
                          itemCount: numberOfDaysInMonth() - now.day + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    sortList();
                                  });
                                  scrollController.animateTo(
                                      70.0 * index + 8.0 * index,
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.decelerate);
                                },
                                child: DateBox(
                                  getDayofWeek(index),
                                  (index + now.day).toString(),
                                  selected:
                                      index == selectedIndex ? true : false,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      _addGap(20.0, 0.0)
                    ],
                  ),
                ),
              ),
              _addGap(1.0, 0.0),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    scrollDirection: Axis.vertical,
                    itemCount: nextIndex - previousIndex + 1,
                    itemBuilder: (BuildContext context, int index) =>
                        _buildTaskTile(context, index, model),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}

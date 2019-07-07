import 'package:flutter/material.dart';
import '../taskout_model.dart';
import 'dart:async';
import '../widgets/text/heading.dart';
import '../widgets/text/subheading.dart';
import '../models/task.dart';
import '../widgets/general/custom_alert_dialog.dart';
import '../widgets/newtask/tags.dart';
import '../widgets/newtask/priority_buttons.dart';
import '../widgets/newtask/deadline.dart';

class AddTask extends StatefulWidget {
  final TaskoutModel _taskoutModel;
  final Function toggleAddTask;
  AddTask(this._taskoutModel, this.toggleAddTask);
  @override
  State<StatefulWidget> createState() {
    return _AddTaskState();
  }
}

class _AddTaskState extends State<AddTask> {
  double opacity = 0.0;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TaskTags taskTags = TaskTags();
  final PriorityButtons priorityButtons = PriorityButtons();
  final Deadline deadline = Deadline();
  bool submitting = false;

  //taskdetails
  String to;
  String title;
  String description;

  Widget _buildBlackSubheading(String text) {
    return Subheading(text, Colors.black);
  }

  Widget _addGap(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  Widget _buildRecipientTextField(String username){
    widget._taskoutModel.setUsernameForTask(null);
    print("Right field");
    return TextFormField(
      initialValue: username,
      validator: (String value) {
        if (value.isEmpty) {
          return "Required";
        }
      },
      onSaved: (String value) {
        to = value;
      },
      cursorColor: Colors.black,
      autocorrect: false,
      maxLines: 1,
      decoration: InputDecoration(
        labelText: "Recipient's Username/Email",
        alignLabelWithHint: false,
        contentPadding: EdgeInsets.all(5.0),
      ),
    );
  }

  Widget _buildTextField(String label, int fieldNo) {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "Required";
        }
      },
      onSaved: (String value) {
        if (fieldNo == 1) {
          to = value;
        } else if (fieldNo == 2) {
          title = value;
        } else if (fieldNo == 3) {
          description = value;
        }
      },
      cursorColor: Colors.black,
      autocorrect: false,
      maxLines: fieldNo == 3 ? 5 : 1,
      decoration: InputDecoration(
        labelText: label,
        alignLabelWithHint: fieldNo == 3 ? true : false,
        contentPadding: EdgeInsets.all(5.0),
      ),
    );
  }

  void addOutsourcedTask() {
    bool fieldsAreNotEmpty = _formKey.currentState.validate();
    if (fieldsAreNotEmpty) {
      setState(() {
        submitting = true;
      });
      _formKey.currentState.save();
        CustomTask task = CustomTask(
          widget._taskoutModel.signedInUserDetailsMap["username"],
          to,
          title,
          description,
          tags: taskTags.tags != null ? taskTags.tags : null,
          date: deadline.dateIsSelected ? deadline.selectedDate : null,
          time: deadline.timeIsSelected ? deadline.selectedTime : null,
          priority: priorityButtons.taskPriority != null
              ? priorityButtons.taskPriority
              : null,
          created: DateTime.now(),
          status: "new",
        );
        widget._taskoutModel.addNewTask(task).then((String value) {
          if (value == "added") {
            CustomAlertDialog().buildCustomAlertDialog(
                context, "Task Delegated", "Task has been sent successfully");
            widget.toggleAddTask();
          } else {
            setState(() {
              submitting = false;
            });
            CustomAlertDialog()
                .buildCustomAlertDialog(context, "Woopsie", value);
          }
        });
    }
  }

  @override
  void initState(){
    super.initState();
    Timer(Duration(milliseconds: 250), (){
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: Duration(
        milliseconds: 400,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Heading(
                  "Add Task",
                  Colors.black,
                  fontSize: 30.0,
                ),
                submitting
                    ? CircularProgressIndicator()
                    : IconButton(
                        onPressed: addOutsourcedTask,
                        icon: Icon(
                          Icons.send,
                          color: Color(0xff4AD284),
                          size: 32.0,
                        ),
                      )
              ],
            ),
            _addGap(2.0, 0.0),
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget._taskoutModel.usernameForTask == null ? _buildTextField("Recipient's Username/Email*", 1) : _buildRecipientTextField(widget._taskoutModel.usernameForTask),
                    _addGap(20.0, 0.0),
                    _buildTextField("Title*", 2),
                    _addGap(20.0, 0.0),
                    _buildTextField("Description*", 3),
                    _addGap(20.0, 0.0),
                    _buildBlackSubheading("Tags"),
                    _addGap(10.0, 0.0),
                    taskTags,
                    _addGap(20.0, 0.0),
                    _buildBlackSubheading("Deadline"),
                    _addGap(10.0, 0.0),
                    deadline,
                    _addGap(20.0, 0.0),
                    _buildBlackSubheading("Priority"),
                    _addGap(10.0, 0.0),
                    priorityButtons,
                    _addGap(20.0, 0.0),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

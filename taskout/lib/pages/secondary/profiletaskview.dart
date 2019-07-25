import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskout/pages/main/task_list.dart';
import 'package:taskout/taskout_model.dart';

class ProfileTaskView extends StatefulWidget {
  final String mode;

  ProfileTaskView({Key key, this.mode}) : super(key: key);

  @override
  _ProfileTaskViewState createState() => _ProfileTaskViewState();
}

class _ProfileTaskViewState extends State<ProfileTaskView> {
  List taskListToUse;
  int taskNum = 0;
  IconData icon;

  void refreshStateOfList() {
    setState(() {
      print("refreshed");
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
      builder: (BuildContext context, Widget child, TaskoutModel model) {
        model.refreshTaskList = refreshStateOfList;
        if (widget.mode == "Received") {
          icon = Icons.call_missed;
          taskNum = model.receivedTasks.length;
          taskListToUse = model.receivedTasks;
        } else {
          icon = Icons.call_missed_outgoing;
          taskNum = model.outsourcedTasks.length;
          taskListToUse = model.outsourcedTasks;
        }
        return Scaffold(
          body: AnimatedContainer(
            duration: Duration(seconds: 1),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 20.0),
                    child: CircleAvatar(
                      child: Icon(
                        icon,
                        color: Colors.black,
                        size: 30.0,
                      ),
                      backgroundColor: Colors.white,
                      radius: 25.0,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 25.0, top: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '$taskNum Tasks',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        Text(
                          '${widget.mode} Tasks',
                          style: TextStyle(
                            fontSize: 30.0,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        LinearPercentIndicator(
                          padding: EdgeInsets.only(left: 5.0, right: 10.0),
                          trailing: Padding(
                            padding: EdgeInsets.only(right: 20.0),
                            child: Text((0.5 * 100).ceil().toString() + '%'),
                          ),
                          percent: 0.5,
                          linearGradient: LinearGradient(
                            colors: [
                              Colors.blue,
                              Colors.blueGrey,
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: ListView.builder(
                        padding: EdgeInsets.all(0.0),
                        scrollDirection: Axis.vertical,
                        itemCount: nextIndex - previousIndex + 1,
                        itemBuilder: (BuildContext context, int index) =>
                            buildTaskTile(
                                context: context,
                                index: index,
                                mode: widget.mode,
                                model: model,
                                taskListToUse: taskListToUse),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

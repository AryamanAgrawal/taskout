import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskout/taskout_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import './secondary/addtask.dart';
import '../widgets/general/task_alert.dart';

//pages import
import './main/home.dart';
import './main/task_list.dart';
import './main/user_preferences.dart';

class PagesManager extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PagesManagerState();
  }
}

class PagesManagerState extends State<PagesManager>
    with SingleTickerProviderStateMixin {
  bool clickedNewTask = false;
  bool taskAlert = false;
  int selectedIndex = 0;
  double opacity = 1.0;
  List<Widget> _pagesList = [
    Home(),
    TaskList(
      mode: "Received",
    ),
    TaskList(
      mode: "Outsourced",
    ),
    UserPreferences()
  ];

  void toggleTaskAlert() {
    setState(() {
      taskAlert = !taskAlert;
    });
  }

  Widget _buildBottomBarIconButton(IconData iconData, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          opacity = 0.0;
        });
        Timer(Duration(milliseconds: 210), () {
          setState(() {
            opacity = 1.0;
            selectedIndex = index;
          });
        });
      },
      iconSize: index == 1 ? 22.0 : 27.0,
      icon: Icon(
        iconData,
        color: selectedIndex == index ? Colors.black : Colors.grey.shade400,
      ),
    );
  }

  void toggleAddTask() {
    setState(() {
      clickedNewTask = !clickedNewTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedOpacity(
            opacity: opacity,
            duration: Duration(milliseconds: 200),
            child: _pagesList[selectedIndex],
          ),
          ScopedModelDescendant<TaskoutModel>(
            builder: (BuildContext context, Widget child, TaskoutModel model) {
              model.toggleNewTaskThroughModel = toggleAddTask;
              model.toggleTaskAlertThroughModel = toggleTaskAlert;
              return Align(
                alignment: FractionalOffset.bottomCenter,
                child: AnimatedContainer(
                  child: Visibility(
                    maintainState: false,
                    visible: clickedNewTask ? true : false,
                    child: AddTask(model),
                  ),
                  duration: Duration(milliseconds: 250),
                  height: clickedNewTask
                      ? MediaQuery.of(context).size.height
                      : 10.0,
                  width: clickedNewTask
                      ? MediaQuery.of(context).size.height
                      : 10.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(clickedNewTask ? 0.0 : 300.0),
                    gradient: LinearGradient(
                      begin: FractionalOffset.topCenter,
                      end: FractionalOffset.bottomCenter,
                      colors: [Colors.white, Colors.grey.shade100],
                    ),
                  ),
                ),
              );
            },
          ),
          taskAlert
              ? TaskAlert(
                  toggle: toggleTaskAlert,
                )
              : Container()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4A69FF),
        onPressed: toggleAddTask,
        tooltip: "Add Task",
        child: Container(
          margin: EdgeInsets.all(15.0),
          child: FlareActor(
            "assets/animations/add_to_close.flr",
            animation: clickedNewTask ? 'open' : 'close',
          ),
        ),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 60.0,
          margin: EdgeInsets.symmetric(
            horizontal: 12.0,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildBottomBarIconButton(Icons.home, 0),
              _buildBottomBarIconButton(Icons.call_received, 1),
              SizedBox(
                width: 50.0,
              ),
              _buildBottomBarIconButton(Icons.call_made, 2),
              _buildBottomBarIconButton(Icons.settings, 3),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
    );
  }
}

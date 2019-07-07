import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskout/taskout_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import './addtask.dart';
import '../widgets/general/task_alert.dart';

//pages import
import './main/home.dart';
import './main/received_task_list.dart';
import './main/outsourced_task_list.dart';
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
  bool taskAlert = true;
  int selectedIndex = 0;
  TabController _tabController;
  List<Widget> _pagesList = [
    Home(),
    ReceivedTaskList(),
    OutsourcedTaskList(),
    UserPreferences()
  ];

  void closeTaskAlert() {
    setState(() {
      taskAlert = false;
    });
  }

  Widget _buildBottomBarIconButton(IconData iconData, int index) {
    return IconButton(
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
        _tabController.animateTo(index);
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
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TabBarView(
            controller: _tabController,
            children: _pagesList,
          ),
          ScopedModelDescendant<TaskoutModel>(
            builder: (BuildContext context, Widget child, TaskoutModel model) {
              model.toggleNewTaskThroughModel = toggleAddTask;
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
                  close: closeTaskAlert,
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
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
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

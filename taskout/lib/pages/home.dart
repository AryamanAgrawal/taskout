import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskout/taskout_model.dart';
import 'package:flare_flutter/flare_actor.dart';
import '../main.dart';
import './addtask.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool clickedNewTask = false;
  int selectedIndex = 0;
  String text = "Home";

  void updateTabSelection(int index, String buttonText) {
    setState(() {
      selectedIndex = index;
      text = buttonText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<TaskoutModel>(
        builder: (BuildContext context, Widget child, TaskoutModel model) {
          return Stack(
            children: <Widget>[
              Align(
                alignment: FractionalOffset.center,
                child: RaisedButton(
                  child: Text(text),
                  onPressed: () {
                    model.logOutUser().then((bool result) {
                      if (result) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => MyApp()));
                      } else {
                        print("Unable to sign out");
                      }
                    });
                  },
                ),
              ),
              Align(
                alignment: FractionalOffset.bottomCenter,
                child: AnimatedContainer(
                  padding: EdgeInsets.all(18.0),
                  child: Visibility(
                    maintainState: false,
                    visible: clickedNewTask ? true : false,
                    child: AddTask(),
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
                      colors: [Colors.white, Colors.grey.shade50],
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff4A69FF),
        onPressed: () {
          setState(() {
            clickedNewTask = !clickedNewTask;
          });
        },
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
              IconButton(
                onPressed: () {
                  updateTabSelection(0, "Home");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.home,
                  color: selectedIndex == 0
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(1, "Outgoing");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.call_made,
                  color: selectedIndex == 1
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              SizedBox(
                width: 50.0,
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(2, "Incoming");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.call_received,
                  color: selectedIndex == 2
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
              IconButton(
                onPressed: () {
                  updateTabSelection(3, "Settings");
                },
                iconSize: 27.0,
                icon: Icon(
                  Icons.settings,
                  color: selectedIndex == 3
                      ? Colors.blue.shade900
                      : Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
    );
  }
}

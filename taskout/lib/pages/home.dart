import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:taskout/taskout_model.dart';
import '../main.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HomeState();
  }
}

class HomeState extends State<Home> {
  bool clickedNewTask = false;
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
                  child: Text("Log Out"),
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
                      color: Colors.blue),
                ),
              )
            ],
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            clickedNewTask = !clickedNewTask;
          });
        },
        tooltip: "Add Task",
        child: Icon(Icons.add),
        elevation: 4.0,
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
        shape: CircularNotchedRectangle(),
        color: Colors.white,
      ),
    );
  }
}

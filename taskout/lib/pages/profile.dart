import 'package:flutter/material.dart';
import 'package:taskout/pages/main/task_list.dart';
import 'package:taskout/widgets/cards/profile_card.dart';
import 'package:taskout/taskout_model.dart';
import 'package:scoped_model/scoped_model.dart';

Color gradientColorBegin;
Color gradientColorEnd;

class ProfileView extends StatefulWidget {
  final int outsourcedTasksNum;
  final int receivedTasksNum;
  final String profileName;

  ProfileView({
    Key key,
    this.outsourcedTasksNum,
    this.receivedTasksNum,
    this.profileName,
  }) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  PageController controller;
  DateTime now = DateTime.now();
  int currentPage = 0;

  List<Color> gradientColors = [
    Color(0xFF514A9D),
    Color(0xFF24C6DC),
    Color(0xFFED8F03),
    Color(0xFFFFB75E),
  ];

  @override
  void initState() {
    super.initState();
    controller = new PageController(
      initialPage: currentPage,
      keepPage: false,
      viewportFraction: 0.7,
    );
    gradientColorBegin = gradientColors[0];
    gradientColorEnd = gradientColors[1];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScopedModelDescendant<TaskoutModel>(
          builder: (BuildContext context, Widget child, TaskoutModel model) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          alignment: Alignment(0.0, 0.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                gradientColorBegin,
                gradientColorEnd,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.home,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'taskout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.settings,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Opacity(
                opacity: 1.0,
                child: Padding(
                  padding: EdgeInsets.only(left: 65.0, top: 30.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0.0, 7.0),
                          spreadRadius: 2.0,
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/profile.jpeg'),
                      radius: 30.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.0, top: 20.0),
                child: Container(
                  child: Text(
                    widget.profileName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 65.0, top: 20.0),
                child: Text(
                  'You only have 4 tasks left by\n Michael Gary Scott',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 70.0, top: 80.0),
                child: Text(
                  'Today : ' + todaysdate(now.month, now),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
              ),
              Container(
                
                child: Expanded(
                  child: PageView(
                    controller: controller,
                    onPageChanged: (value) {
                      setState(() {
                        currentPage = value;
                        if (value == 0) {
                          gradientColorBegin = gradientColors[0];
                          gradientColorEnd = gradientColors[1];
                        } else if (value == 1) {
                          gradientColorBegin = gradientColors[2];
                          gradientColorEnd = gradientColors[3];
                        } else if (value == 2) {}
                      });
                    },
                    children: <Widget>[
                      ProfileCard(
                        controller: controller,
                        gradientColorBegin: gradientColorBegin,
                        gradientColorEnd: gradientColorEnd,
                        index: 0,
                        perCompleted: 0.2,
                        totalTasks: widget.outsourcedTasksNum,
                        mode: 'Outsourced',
                      ),
                      ProfileCard(
                        controller: controller,
                        gradientColorBegin: gradientColorBegin,
                        gradientColorEnd: gradientColorEnd,
                        index: 1,
                        perCompleted: 0.8,
                        totalTasks: widget.receivedTasksNum,
                        mode: 'Received',
                      ),
                      ProfileCard(
                        controller: controller,
                        gradientColorBegin: gradientColorBegin,
                        gradientColorEnd: gradientColorEnd,
                        index: 2,
                        perCompleted: 0.7,
                        totalTasks: 20,
                        mode: 'Others',
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        );
      }),
    );
  }
}

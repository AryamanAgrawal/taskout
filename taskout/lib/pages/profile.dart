import 'package:flutter/material.dart';
import 'package:taskout/widgets/cards/profile_card.dart';
import 'package:taskout/taskout_model.dart';
import 'package:scoped_model/scoped_model.dart';

Color gradientColorBegin;
Color gradientColorEnd;

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  PageController controller;
  
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
                      onPressed: () {},
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
              Padding(
                padding: EdgeInsets.only(left: 70.0, top: 60.0),
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
              Padding(
                padding: EdgeInsets.only(left: 65.0, top: 25.0),
                child: Container(
                  child: Text(
                    'Hello, Aryaman.',
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
                padding: EdgeInsets.only(left: 70.0, top: 50.0),
                child: Text(
                  'Today : July 9, 2019',
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
                        if (value % 2 == 0) {
                          gradientColorBegin = gradientColors[0];
                          gradientColorEnd = gradientColors[1];
                        } else {
                          gradientColorBegin = gradientColors[2];
                          gradientColorEnd = gradientColors[3];
                        }
                      });
                    },
                    children: <Widget>[
                      ProfileCard(
                        controller: controller,
                        gradientColorBegin: gradientColorBegin,
                        gradientColorEnd: gradientColorEnd,
                        index: 0,
                        labelIcon: Icons.person,
                        labelText: 'Work',
                        perCompleted: 0.2,
                        totalTasks: 15,
                      ),
                      ProfileCard(
                        controller: controller,
                        gradientColorBegin: gradientColorBegin,
                        gradientColorEnd: gradientColorEnd,
                        index: 1,
                        labelIcon: Icons.offline_bolt,
                        labelText: 'Personal',
                        perCompleted: 0.8,
                        totalTasks: 8,
                      ),
                      ProfileCard(
                        controller: controller,
                        gradientColorBegin: gradientColorBegin,
                        gradientColorEnd: gradientColorEnd,
                        index: 2,
                        labelIcon: Icons.home,
                        labelText: 'Home',
                        perCompleted: 0.7,
                        totalTasks: 20,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        );}
        ),
      );
    
  }
}

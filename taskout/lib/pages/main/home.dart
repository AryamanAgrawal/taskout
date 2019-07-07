import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../taskout_model.dart';
import '../../widgets/home/favorite_person.dart';
import '../../widgets/general/text.dart';
import '../../widgets/home/task_summary_circle.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  double marginFromLeft = 0.0;
  Widget _addGap(double height, double width) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(bottom: 10.0),
      color: Color(0xfff9fafc),
      child: ScopedModelDescendant<TaskoutModel>(
        builder: (BuildContext context, Widget child, TaskoutModel model) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Material(
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(50.0)),
                elevation: 3.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50.0)),
                  ),
                  padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 30.0),
                  child: Column(
                    children: <Widget>[
                      _addGap(40.0, 0.0),
                      Heading(
                        "Taskout",
                        Colors.black,
                        fontSize: 34.0,
                      ),
                      _addGap(10.0, 0.0),
                      CaptionText(
                        model.signedInUserDetailsMap["username"] +
                            "'s taskout summary:",
                        Colors.black45,
                        textAlign: TextAlign.center,
                      ),
                      _addGap(20.0, 0.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TaskSummaryCircle(30, 38, Icons.call_received),
                          TaskSummaryCircle(20, 47, Icons.call_made)
                        ],
                      )
                    ],
                  ),
                ),
              ),
              _addGap(20.0, 0.0),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Subheading(
                  "Favorites",
                  Colors.black45,
                  textAlign: TextAlign.start,
                  fontSize: 16.0,
                ),
              ),
              _addGap(5.0, 0.0),
              FavoritePerson(
                "Padam Chopra",
                "padamchopra",
                50,
                85,
                taskoutModel: model,
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../general/text.dart';
import './task_summary_circle.dart';
import '../../taskout_model.dart';

class FavoritePerson extends StatefulWidget {
  final String name;
  final String username;
  final int completed;
  final int total;
  final TaskoutModel taskoutModel;
  FavoritePerson(this.name, this.username, this.completed, this.total,
      {this.taskoutModel});

  @override
  State<StatefulWidget> createState() {
    return _FavoritePersonState();
  }
}

class _FavoritePersonState extends State<FavoritePerson> {
  double marginLeft = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
        vertical: 5.0,
      ),
      child: Material(
        elevation: 2.0,
        borderRadius: BorderRadius.circular(12.0),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                widget.taskoutModel.setUsernameForTask(widget.username);
                setState(() {
                  marginLeft = 0.0;
                });
                widget.taskoutModel.toggleNewTaskThroughModel();
              },
              child: Container(
                height: 90.0,
                padding: EdgeInsets.only(
                  left: 20.0,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topLeft,
                    end: FractionalOffset.bottomCenter,
                    colors: [Color(0xff07a192), Color(0xff00d565)],
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Align(
                  alignment: FractionalOffset.centerLeft,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            GestureDetector(
              onHorizontalDragUpdate: (DragUpdateDetails drag) {
                if (marginLeft < 60.0 && drag.delta.dx > 0) {
                  setState(() {
                    marginLeft += drag.delta.distance;
                  });
                } else if (drag.delta.dx < 0) {
                  setState(() {
                    marginLeft = 0.0;
                  });
                }
              },
              onHorizontalDragEnd: (DragEndDetails drag) {
                if (marginLeft < 60.0) {
                  setState(() {
                    marginLeft = 0.0;
                  });
                }
              },
              child: AnimatedContainer(
                margin: EdgeInsets.only(
                  left: marginLeft,
                ),
                duration: Duration(
                  milliseconds: 250,
                ),
                height: 90.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Heading(
                          widget.name,
                          Colors.black,
                          fontSize: 18.0,
                        ),
                        CaptionText(widget.username, Colors.grey.shade500)
                      ],
                    ),
                    TaskSummaryCircle(
                      widget.completed,
                      widget.total,
                      Icons.thumbs_up_down,
                      size: 50.0,
                      forFavorite: true,
                    )
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

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileCard extends StatefulWidget {
  final Color gradientColorBegin;
  final Color gradientColorEnd;
  final String labelText;
  final int totalTasks;
  final double perCompleted;
  final IconData labelIcon;
  final PageController controller;
  final int index;

  ProfileCard({
    Key key,
    @required this.labelIcon,
    @required this.perCompleted,
    @required this.totalTasks,
    @required this.labelText,
    @required this.gradientColorBegin,
    @required this.gradientColorEnd,
    @required this.controller,
    @required this.index,
  }) : super(key: key);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        double value = 1.0;
        if (widget.controller.position.haveDimensions) {
          value = widget.controller.page - widget.index;
          value = (1 - (value.abs() * 0.3)).clamp(0.0, 5.0);
        }

        return Center(
          child: SizedBox(
            height: Curves.easeOut.transform(value) * 300,
            width: Curves.easeOut.transform(value) * 280,
            child: child,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              offset: Offset(0.0, 5.0),
              spreadRadius: 2.0,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CircleAvatar(
                child: Icon(
                  widget.labelIcon,
                  color: Colors.white,
                ),
                backgroundColor: widget.gradientColorBegin,
                radius: 25.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.totalTasks.toString() + ' Tasks',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    Text(
                      widget.labelText,
                      style: TextStyle(
                        fontSize: 30.0,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    LinearPercentIndicator(
                      padding: EdgeInsets.only(right: 10.0),
                      trailing: Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child:
                            Text((widget.perCompleted * 100).ceil().toString() + '%'),
                      ),
                      percent: widget.perCompleted,
                      linearGradient: LinearGradient(
                        colors: [
                          widget.gradientColorBegin,
                          widget.gradientColorEnd,
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

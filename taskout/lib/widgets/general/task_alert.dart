import 'dart:async';
import 'package:flutter/material.dart';
import './text.dart';
import './custom_chip.dart';

class TaskAlert extends StatefulWidget {
  final Function toggle;
  TaskAlert({this.toggle});

  @override
  State<StatefulWidget> createState() {
    return _TaskAlertState();
  }
}

class _TaskAlertState extends State<TaskAlert> {
  double translateY = 500.0;

  void _dismissAlert() {
    setState(() {
      translateY = 500.0;
    });
    Timer(Duration(milliseconds: 460), () {
      widget.toggle();
    });
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
      setState(() {
        translateY = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: FractionalOffset.bottomCenter,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 450),
        curve: Curves.easeInBack,
        transform: Matrix4.translationValues(0.0, translateY, 0.0),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 2.0,
              offset: Offset(0.0, -3.0),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  Icons.assignment,
                  color: Colors.green.shade500,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Heading(
                  "GIC Payment",
                  Colors.black,
                  fontSize: 18.0,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Heading(
                        "From:",
                        Colors.black,
                        fontSize: 15.0,
                      ),
                      Subheading("vivekchopra", Colors.black)
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Heading(
                        "To:",
                        Colors.black,
                        fontSize: 15.0,
                      ),
                      Subheading("padamchopra", Colors.black)
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: CaptionText(
                "Please generate your GIC payment instructions with CIBC and email them to me at both my office and personal email address",
                Colors.black87,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              children: <Widget>[
                Heading(
                  "Due by:",
                  Colors.black,
                  fontSize: 15.0,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Subheading("05:00 PM on 15 July 2019", Colors.black)
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                CustomChip(
                  "Home",
                  Colors.green.shade300,
                  rightMargin: 8.0,
                ),
                CustomChip("Personal", Colors.green.shade300)
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                OutlineButton(
                  //TODO: Add function to reject task
                  onPressed: _dismissAlert,
                  child: Subheading(
                    "REJECT",
                    Colors.black,
                    fontSize: 12.0,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                FlatButton(
                  //TODO: Add function to accept task
                  onPressed: _dismissAlert,
                  child: Subheading(
                    "ACCEPT",
                    Colors.white,
                    fontSize: 12.0,
                  ),
                  color: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

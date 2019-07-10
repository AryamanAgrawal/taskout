import 'package:flutter/material.dart';
import '../general/text.dart';

class TaskTile extends StatelessWidget {
  final Color color;
  final String title;
  final String status;
  final String toOrFrom;
  final String deadlinetime;
  final bool hasPassed;
  TaskTile(
      {this.color,
      @required this.title,
      @required this.toOrFrom,
      @required this.status,
      this.deadlinetime,
      this.hasPassed = false});

  Widget _getDueBy() {
    if (deadlinetime != null && hasPassed == false) {
      return CaptionText(
        "Due by: " + deadlinetime,
        Colors.black45,
        textAlign: TextAlign.start,
      );
    } else if (deadlinetime != null && hasPassed) {
      return Subheading(
        "Was due by " + deadlinetime,
        Colors.black,
        textAlign: TextAlign.start,
        fontSize: 13.0,
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      padding: EdgeInsets.fromLTRB(hasPassed ? 23.5 : 30.0,
          hasPassed ? 30.0 : 15.0, 30.0, hasPassed ? 30.0 : 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            hasPassed ? Icons.sentiment_very_dissatisfied : Icons.assignment,
            size: hasPassed ? 40.0 : 30.0,
            color: hasPassed
                ? Colors.red.shade500
                : color == null ? Colors.grey.shade200 : color,
          ),
          SizedBox(
            width: hasPassed ? 17.5 : 20.0,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Heading(
                    title,
                    Colors.black,
                    fontSize: 20.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  CaptionText(
                    hasPassed ? "[LATE]" : "[$status]",
                    hasPassed ? Colors.red.shade500 : Colors.black45,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              SizedBox(
                height: hasPassed ? 8.0 : 5.0,
              ),
              hasPassed
                  ? Subheading(toOrFrom, Colors.black)
                  : CaptionText(
                      toOrFrom,
                      Colors.black45,
                      textAlign: TextAlign.start,
                    ),
              _getDueBy(),
            ],
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../general/circle_progress_bar.dart';
import '../text/subheading.dart';
import '../text/caption_text.dart';

class TaskSummaryCircle extends StatelessWidget {
  final int completed;
  final int total;
  final IconData iconData;
  final double size;
  final bool forFavorite;

  TaskSummaryCircle(this.completed, this.total, this.iconData,
      {this.size = 100.0, this.forFavorite = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      child: Stack(
        alignment: FractionalOffset.center,
        children: <Widget>[
          CircleProgressBar(
            foregroundColor: Color(0xff4A69FF),
            value: completed / total,
            backgroundColor: Colors.grey.shade200,
          ),
          forFavorite
              ? Container()
              : Align(
                  alignment: FractionalOffset.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: 2.0),
                    padding: EdgeInsets.all(7.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                    ),
                    child: Icon(
                      iconData,
                      color: Colors.white,
                      size: 15.0,
                    ),
                  ),
                ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Subheading(
                  forFavorite
                      ? completed.toString()
                      : completed.toString() + "/" + total.toString(),
                  Colors.black),
              forFavorite
                  ? Container()
                  : CaptionText("Completed", Colors.black54)
            ],
          )
        ],
      ),
    );
  }
}

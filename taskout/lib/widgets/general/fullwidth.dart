import 'package:flutter/material.dart';

class FullWidth extends StatelessWidget{
  final Widget widget;
  final double padding;
  FullWidth({@required this.widget, this.padding = 0.0});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: padding),
      width: MediaQuery.of(context).size.width,
      child: widget,
    );
  }
}